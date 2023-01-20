Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC30674D02
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 07:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjATGHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 01:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjATGHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 01:07:08 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E88A4207
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 22:07:06 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id u3so1130954uae.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jan 2023 22:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp+h9NmZyPNJKHS7TYnkvL13e2IxM/XjaZlZElSBaKk=;
        b=Mbcjs8s9OdE+EYAIoH1Siwg3gzySo5+FBxXnBe4aA5rGH5zn8z2eYszqGfATHj009S
         9HPVea646xoY5nCzj6x2u11tPW1ScXMyTFTjY6yJuZYQoje3vvCtfm/yh9r+W9CykhoT
         33kEuIbnSLQugGmnczJuDoD39/ol06/YSiGEYrJMrUBAW3nxEOUfdVBovDLoYta3YxGK
         PVzMetPhjqR8DjsMEgDgqqvqgpkWLsKvYwUXDH7GUHB7bj6QDt/ybhDZNPiNrFhL+rar
         p1y1kTbZPjwicjqJv3MekqCNuFQteJ0/PfjDHX/x1ieQPfeAlOMY7PiRlFT4WRLQopcD
         OyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp+h9NmZyPNJKHS7TYnkvL13e2IxM/XjaZlZElSBaKk=;
        b=d0MxXNQxii2MP/h9HsYPmx+1nbm18iSb7rS6mxLSqaCP5yiw9I+t8dJVwGn4CpXJFC
         C6+BiNIJaEchatdjeuDy+xpnlDHlw77rQY0IJSuyu/mP/ZwKMMezlWKsMP/aPnfqgf0k
         SMTHBZsngUt3qaiPG3HYWp3glB+4lUvNtfnZr9bUyiDn0EuRyX0T+HagLVqReADUKS0b
         AfpRe052hfQPyEGn9L02I579rEDWSmMH/msPbpCNfRoIxOaMeDeLhrpKgQ+lbETZ5GSQ
         3s4zcdzIeK+JcE2KAtededS7qEiB8dUxZeoShoXpk5ydvuQHSLYcCbSluCYcolDvc42T
         m8Cg==
X-Gm-Message-State: AFqh2kr6UeDE77lSIwypR3qUT8trVFaURtWHDHrdpa47D9yP3GI2kGGE
        CH3p1IviuE6cGaXkRamolG8xMQhCfjgLtt/E3mi2aQ==
X-Google-Smtp-Source: AMrXdXuWT3vD9GQIy8S4uPA/JHQhEK2M1KYEObj8SeD6laIP1YJn0QcvHlysT6CnZMpiJ+P0H72bBg9aeJLb6B9sGvk=
X-Received: by 2002:a05:6130:1086:b0:609:218b:c8d5 with SMTP id
 cd6-20020a056130108600b00609218bc8d5mr1706638uab.104.1674194825355; Thu, 19
 Jan 2023 22:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20230117215046.3734066-1-rmoar@google.com>
In-Reply-To: <20230117215046.3734066-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 20 Jan 2023 14:06:53 +0800
Message-ID: <CABVgOSk85sNKxRF9CZfiTpBLJMzLn4LzmbJYb7sAaNSZaw4_WQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/hashtable_test.c: add test for the hashtable structure
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000df5d2c05f2abdbfb"
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

--000000000000df5d2c05f2abdbfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jan 2023 at 05:50, Rae Moar <rmoar@google.com> wrote:
>
> Add a KUnit test for the kernel hashtable implementation in
> include/linux/hashtable.h.
>
> Note that this version does not yet test each of the rcu
> alternative versions of functions.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks good, and TBH, I could accept it as-is. There are a few
very minor stylistic nitpicks below, but there are a couple of bigger
issues, too:
- DEFINE_HASHTABLE() should initialise the hashtable itself, so you
shouldn't need to also call hash_init().
- It'd be nice if we had some hashtables of different sizes. At the
moment, they're all 3-bit (8 entries). Let's mix it up a little bit.

With those two changes (and optionally, any of the stylistic ones
below), this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v1:
> - Change Kconfig.debug message to be more succinct.
> - Directly increment current element's visited field rather than looking
>   up corresponding element.
> - Use KUNIT_EXPECT_=E2=80=A6 statements to check keys are within range ra=
ther
>   than using if statements.
> - Change hash_for_each_possible test to check buckets using a
>   hash_for_each method instead of calculating the bucket number using
>   hash_min.
>
> Note: The check patch script is outputting open brace errors on lines
> 158, 192, 247 of lib/hashtable_test.c. However, I think these errors are
> a mistake as the format of the braces on those lines seems consistent
> with the Linux Kernel style guide.
>

This is a known issue with checkpatch and function names with
"for_each" in them. It was discussed here, and we ultimately decided
just to ignore the warnings:
https://lore.kernel.org/all/CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAw=
zNiQ@mail.gmail.com/

>  lib/Kconfig.debug    |  13 ++
>  lib/Makefile         |   1 +
>  lib/hashtable_test.c | 326 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 340 insertions(+)
>  create mode 100644 lib/hashtable_test.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 881c3f84e88a..69b1452a3eeb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2496,6 +2496,19 @@ config LIST_KUNIT_TEST
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
> +         It tests the basic functionality of the API defined in
> +         include/linux/hashtable.h. For more information on KUnit and
> +         unit tests in general please refer to the KUnit documentation
> +         in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config LINEAR_RANGES_TEST
>         tristate "KUnit test for linear_ranges"
>         depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..5f8efbe8e97f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -369,6 +369,7 @@ obj-$(CONFIG_PLDMFW) +=3D pldmfw/
>  CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
> +obj-$(CONFIG_HASHTABLE_KUNIT_TEST) +=3D hashtable_test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
> diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
> new file mode 100644
> index 000000000000..ab09b747d83d
> --- /dev/null
> +++ b/lib/hashtable_test.c
> @@ -0,0 +1,326 @@
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

As I understand it, DEFINE_HASHTABLE shouldn't need a hash_init(), but
DECLARE_HASHTABLE() does?

Could we make that clearer (and in so doing, get rid of the hash_init
for all hashtables which were DEFINE_HASHTABLE()ed?

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

I guess it doesn't matter what (if any) data is in 'a', so this isn't
strictly necessary. I don't mind having it though, as it's nice to
have some actual data to add.

If you really wanted, you could just add a struct hlist_node directly,
rather than struct hashtable_test_entry, though again, this is a more
realistic-looking test as-is, so I'm okay with keeping it.

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

Nit: I might put the initialisation of the data in the same block as
adding them. Or possibly do something like:
a.key =3D 1;
a.data =3D =E2=80=A6;
hash_add(=E2=80=A6);
b.key =3D 1;
b.data =3D =E2=80=A6;
hash_add(=E2=80=A6);

Not something I actually care too much about, though: this is readable
enough as-is.

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

As above, can we reorder these to do everything with a, then
everything with b (and remove the hash_init)?

> +
> +       hash_for_each(hash, bkt, x, node) {
> +               x->visited++;
> +               if (x->key =3D=3D a.key)
> +                       KUNIT_EXPECT_EQ(test, x->data, 13);
> +               else if (x->key =3D=3D b.key)
> +                       KUNIT_EXPECT_EQ(test, x->data, 10);
> +               else
> +                       KUNIT_FAIL(test, "Unexpected key in hashtable.");
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

As above, maybe adjust the spacing here. Though, to be honest, I don't
think it matters _quite_ as much once you get rid of hash_init().
Still probably better to do [init a][add a][init b][add b], IMO,
though.

> +
> +       hash_del(&b.node);
> +       hash_for_each_possible(hash, x, node, b.key) {
> +               x->visited++;
> +               KUNIT_EXPECT_NE(test, x->key, b.key);
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
> +               x->visited +=3D 1;
> +               KUNIT_ASSERT_GE(test, x->key, 0);
> +               KUNIT_ASSERT_LT(test, x->key, 3);
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
> +               x->visited +=3D 1;
> +               KUNIT_ASSERT_GE(test, x->key, 0);
> +               KUNIT_ASSERT_LT(test, x->key, 3);
> +               count++;
> +
> +               /* Delete entry during loop. */
> +               hash_del(&x->node);
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
> +       struct hashtable_test_entry *x, *y;
> +       int buckets[2];
> +       int bkt, i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries with key =3D 0. */
> +       hash_init(hash);
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D 0;
> +               entries[i].data =3D i;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       /* Add an entry with key =3D 1. */
> +       entries[3].key =3D 1;
> +       entries[3].data =3D 3;
> +       entries[3].visited =3D 0;
> +       hash_add(hash, &entries[3].node, entries[3].key);
> +
> +       count =3D 0;
> +       hash_for_each_possible(hash, x, node, 0) {
> +               x->visited +=3D 1;
> +               KUNIT_ASSERT_GE(test, x->data, 0);
> +               KUNIT_ASSERT_LT(test, x->data, 4);
> +               count++;
> +       }
> +
> +       /* Should have visited each entry with key =3D 0 exactly once. */
> +       for (j =3D 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +
> +       /* Save the buckets for the different keys. */
> +       hash_for_each(hash, bkt, y, node) {
> +               if (y->key < 0 || y->key > 1)
> +                       KUNIT_ASSERT_FAILURE(test, "Unexpected key in has=
htable.");

Nit: could we just use KUNIT_ASSERT_LEQ() and KUNIT_ASSERT_GEQ() here?
(Or better still, their _MSG variants)?

> +               buckets[y->key] =3D bkt;
> +       }
> +
> +       /* If entry with key =3D 1 is in the same bucket as the entries w=
ith
> +        * key =3D 0, check it was visited. Otherwise ensure that only th=
ree
> +        * entries were visited.
> +        */
> +       if (buckets[0] =3D=3D buckets[1]) {
> +               KUNIT_EXPECT_EQ(test, count, 4);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> +       } else {
> +               KUNIT_EXPECT_EQ(test, count, 3);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 0);
> +       }
> +}
> +
> +static void hashtable_test_hash_for_each_possible_safe(struct kunit *tes=
t)
> +{
> +       struct hashtable_test_entry entries[4];
> +       struct hashtable_test_entry *x, *y;
> +       struct hlist_node *tmp;
> +       int buckets[2];
> +       int bkt, i, j, count;
> +       DEFINE_HASHTABLE(hash, 3);
> +
> +       /* Initialize a hashtable with three entries with key =3D 0. */
> +       hash_init(hash);
> +       for (i =3D 0; i < 3; i++) {
> +               entries[i].key =3D 0;
> +               entries[i].data =3D i;
> +               entries[i].visited =3D 0;
> +               hash_add(hash, &entries[i].node, entries[i].key);
> +       }
> +
> +       /* Add an entry with key =3D 1. */
> +       entries[3].key =3D 1;
> +       entries[3].data =3D 3;
> +       entries[3].visited =3D 0;
> +       hash_add(hash, &entries[3].node, entries[3].key);
> +
> +       count =3D 0;
> +       hash_for_each_possible_safe(hash, x, tmp, node, 0) {
> +               x->visited +=3D 1;
> +               KUNIT_ASSERT_GE(test, x->data, 0);
> +               KUNIT_ASSERT_LT(test, x->data, 4);
> +               count++;
> +
> +               /* Delete entry during loop. */
> +               hash_del(&x->node);
> +       }
> +
> +       /* Should have visited each entry with key =3D 0 exactly once. */
> +       for (j =3D 0; j < 3; j++)
> +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> +
> +       /* Save the buckets for the different keys. */
> +       hash_for_each(hash, bkt, y, node) {
> +               if (y->key < 0 || y->key > 1)
> +                       KUNIT_ASSERT_FAILURE(test, "Unexpected key in has=
htable.");

Nit: could we just use KUNIT_ASSERT_LEQ() and KUNIT_ASSERT_GEQ() here?
(Or better still, their _MSG variants)?

> +               buckets[y->key] =3D bkt;
> +       }
> +
> +       /* If entry with key =3D 1 is in the same bucket as the entries w=
ith
> +        * key =3D 0, check it was visited. Otherwise ensure that only th=
ree
> +        * entries were visited.
> +        */
> +       if (buckets[0] =3D=3D buckets[1]) {
> +               KUNIT_EXPECT_EQ(test, count, 4);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> +       } else {
> +               KUNIT_EXPECT_EQ(test, count, 3);
> +               KUNIT_EXPECT_EQ(test, entries[3].visited, 0);
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
> base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
> --
> 2.39.0.314.g84b9a713c41-goog
>

--000000000000df5d2c05f2abdbfb
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA6
EVcjNjzJxc5UYBBc/vwrrit8URpSU9thw3HKYGvBZzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMjAwNjA3MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcam5IZQbsmWLbuukFT9E
JUlaqXGBMsvAMlKVgNFaPaRnaapDT1VHDH5QPmEZc7JlgB5jl6uxSBZGkalYxw/xbNaKT/FHVV6r
nTOLRImZlAGDtvzkJrsZSJQfBXhGXW/0SFk1kDUMryShSL/0UYmU2Rhk6IGUOjfCmMO9reI68RIy
WrEGF1jwSleeiKJ6tyJQKtQ8kIV8mj6FZJ/KlhlRA3EwsyVJKJwRAEdIfyGAsOc/B5iFXzQRbwLr
JjLW1qMIVITiwzHGg3jGQyWkrve8cucDvv47yR1z2xhhQ6SdqRcknMjkrcngtvahL8eM1aN+bPBl
TpZPGIJTvctIo/U8xg==
--000000000000df5d2c05f2abdbfb--
