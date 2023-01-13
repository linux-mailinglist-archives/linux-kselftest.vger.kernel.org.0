Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46566A5DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjAMWXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Jan 2023 17:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAMWXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Jan 2023 17:23:24 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F5D76EDB
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 14:23:22 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-15b9c93848dso15533555fac.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9fyweIDEPmWr/lZahgcMURtuZX9znfqDKeRUR/Vg14=;
        b=Izd0QFv5zZ4sNOIJRLqu8TUyfJNoOFrulZQmLf0Z8Ejglu1M+YQTs8GnWsq44/lXrK
         a3HLnlL8JxuiX47indm2TNCcV9+e7iRVrp6En977dv0eaH5LnKie3uwq3UIl2ZUTcj93
         X8eaCRONY9+VKJkXz2/FRi8gDH0qkrHbhN1XvfnJJdzKb5zN1BDajULoHPtCrZQ8DNDK
         /plqEO7CX/CJy9HdLB4G8rqiGKAKX7u0Fd9pwC4Q82lfRVo25dhi6I++7POQ12xZbrsn
         f9PboYI2h2Nns267/og7GqoBz5TKH2I/nZzyR94YxYgrYsBHneJ4uzXQ2Cd8WO8wgOmN
         d7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9fyweIDEPmWr/lZahgcMURtuZX9znfqDKeRUR/Vg14=;
        b=4uFXkQoobs/6usk700ksUKUxPlNiyddn1neFn9sy43oA++BdJ/Xx8YyeQwgqCqsfgo
         KoR6PpZ+2h7tbSDP4397EiaEr0iCl0D3Kf0mJKvx3PSNa0mt2u7OoH/cKDi1mCELEIgs
         g9vJV0zhTAhb8xKVCjk45cTUwRBp3Fpg3M1/ylwA282euHQXdqYJK+nrw/S45ZNRDArT
         K/RmHA9VlDheSTt7pT997/lh2zQM6OELsgReg2CF3UAU1HSjEHJBl3ZNxFl7x5k5w1en
         kXw2II64wUx3/yUNx2vjtZ/1LjbgcFUOXg4Q8/U4AnigZ5JXcx90e1GohBOhxyKj7FEL
         wfFg==
X-Gm-Message-State: AFqh2kodvD+E2jxPaeGimvTonRR0ddExgI/MX+4IMYcmjJ99lav6L2+L
        6rensHFjWNl56eB0/u98DZ2Ii27n4mgWU+gYn9td7w==
X-Google-Smtp-Source: AMrXdXsNF+oEMA8KCHtHjnrnPMlroU5KeqqGe61b7gn3/mjfSOPjZqPIOQYuqBmMDEWa1k29/spFL6XpZZU7GqaoVHk=
X-Received: by 2002:a05:6870:c90e:b0:15b:b80c:e3bd with SMTP id
 hj14-20020a056870c90e00b0015bb80ce3bdmr1035163oab.273.1673648601546; Fri, 13
 Jan 2023 14:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20221220031023.197178-1-rmoar@google.com> <CAGS_qxrp_oT7b_NNP4PfES06QAp-V4B4BAETFd3Wv9x-F8Zhrg@mail.gmail.com>
In-Reply-To: <CAGS_qxrp_oT7b_NNP4PfES06QAp-V4B4BAETFd3Wv9x-F8Zhrg@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 13 Jan 2023 17:23:10 -0500
Message-ID: <CA+GJov4cyXhLnVtSMB8vBzscN0_y4fmSegEJjCr1aY51aCs5Bg@mail.gmail.com>
Subject: Re: [PATCH v1] lib/hashtable_test.c: add test for the hashtable structure
To:     Daniel Latypov <dlatypov@google.com>
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

On Tue, Dec 27, 2022 at 9:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Dec 19, 2022 at 7:16 PM Rae Moar <rmoar@google.com> wrote:
> >
> > Add a KUnit test for the kernel hashtable implementation in
> > include/linux/hashtable.h.
> >
> > Note that this version does not yet test each of the rcu
> > alternative versions of functions.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
>
> Looks pretty good from a cursory glance.
> Had some mostly stylistic nits/suggestions below.
>
> > ---
> >
> > Note: The check patch script is outputting open brace errors on lines
> > 154, 186, 231 of lib/hashtable_test.c but I believe the format of the
> > braces on those lines is consistent with the Linux Kernel style guide.
> > Will continue to look at these errors.
> >
> >  lib/Kconfig.debug    |  13 ++
> >  lib/Makefile         |   1 +
> >  lib/hashtable_test.c | 299 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 313 insertions(+)
> >  create mode 100644 lib/hashtable_test.c
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3fc7abffc7aa..3cf3b6f8cff4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2458,6 +2458,19 @@ config LIST_KUNIT_TEST
> >
> >           If unsure, say N.
> >
> > +config HASHTABLE_KUNIT_TEST
> > +       tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         This builds the hashtable KUnit test suite.
> > +         It tests the API and basic functionality of the functions
> > +         and associated macros defined in include/linux/hashtable.h.
>
> nit: the "functions and associated macros" == "the API", so perhaps we
> can shorten this a bit.

This seems better to me. Thanks!

>
> > +         For more information on KUnit and unit tests in general please refer
> > +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +         If unsure, say N.
> > +
> >  config LINEAR_RANGES_TEST
> >         tristate "KUnit test for linear_ranges"
> >         depends on KUNIT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 161d6a724ff7..9036d3aeee0a 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
> >  CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
> >  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> > +obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> >  obj-$(CONFIG_BITS_TEST) += test_bits.o
> >  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> > diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
> > new file mode 100644
> > index 000000000000..7907df66a8e7
> > --- /dev/null
> > +++ b/lib/hashtable_test.c
> > @@ -0,0 +1,299 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for the Kernel Hashtable structures.
> > + *
> > + * Copyright (C) 2022, Google LLC.
> > + * Author: Rae Moar <rmoar@google.com>
> > + */
> > +#include <kunit/test.h>
> > +
> > +#include <linux/hashtable.h>
> > +
> > +struct hashtable_test_entry {
> > +       int key;
> > +       int data;
> > +       struct hlist_node node;
> > +       int visited;
> > +};
> > +
> > +static void hashtable_test_hash_init(struct kunit *test)
> > +{
> > +       /* Test the different ways of initialising a hashtable. */
> > +       DEFINE_HASHTABLE(hash1, 3);
> > +       DECLARE_HASHTABLE(hash2, 3);
> > +
> > +       hash_init(hash1);
> > +       hash_init(hash2);
> > +
> > +       KUNIT_EXPECT_TRUE(test, hash_empty(hash1));
> > +       KUNIT_EXPECT_TRUE(test, hash_empty(hash2));
> > +}
> > +
> > +static void hashtable_test_hash_empty(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry a;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       hash_init(hash);
> > +       KUNIT_EXPECT_TRUE(test, hash_empty(hash));
> > +
> > +       a.key = 1;
> > +       a.data = 13;
> > +       hash_add(hash, &a.node, a.key);
> > +
> > +       /* Hashtable should no longer be empty. */
> > +       KUNIT_EXPECT_FALSE(test, hash_empty(hash));
> > +}
> > +
> > +static void hashtable_test_hash_hashed(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry a, b;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       hash_init(hash);
> > +       a.key = 1;
> > +       a.data = 13;
> > +       b.key = 1;
> > +       b.data = 2;
> > +
> > +       hash_add(hash, &a.node, a.key);
> > +       hash_add(hash, &b.node, b.key);
> > +
> > +       KUNIT_EXPECT_TRUE(test, hash_hashed(&a.node));
> > +       KUNIT_EXPECT_TRUE(test, hash_hashed(&b.node));
> > +}
> > +
> > +static void hashtable_test_hash_add(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry a, b, *x;
> > +       int bkt;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       hash_init(hash);
> > +       a.key = 1;
> > +       a.data = 13;
> > +       a.visited = 0;
> > +       b.key = 2;
> > +       b.data = 10;
> > +       b.visited = 0;
> > +
> > +       hash_add(hash, &a.node, a.key);
> > +       hash_add(hash, &b.node, b.key);
> > +
> > +       hash_for_each(hash, bkt, x, node) {
> > +               if (x->key == a.key && x->data == a.data)
> > +                       a.visited += 1;
> > +               if (x->key == b.key && x->data == b.data)
> > +                       b.visited += 1;
> > +       }
>
>   x->visited += 1;
> or
>   x->visited++;
> also do the same thing.

Oh right. That makes a lot of sense.

>
> Note: given x is supposed to point to a or b, I don't know if checking
> against a.data does us much good.
> If we're trying to check that hash_add() doesn't mutate the keys and
> data, this code won't catch it.
> We'd have to instead do something like
>   if(x->key != 1 && x->key != 2) KUNIT_FAIL(test, ...);
>

This seems like a good change to me in combination with changing it to
x->visited++;.
Although David's suggestion might be slightly more exhaustive.
Why wouldn't it be important to check that the key matches the data?

> > +
> > +       /* Both entries should have been visited exactly once. */
> > +       KUNIT_EXPECT_EQ(test, a.visited, 1);
> > +       KUNIT_EXPECT_EQ(test, b.visited, 1);
> > +}
> > +
> > +static void hashtable_test_hash_del(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry a, b, *x;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       hash_init(hash);
> > +       a.key = 1;
> > +       a.data = 13;
> > +       b.key = 2;
> > +       b.data = 10;
> > +       b.visited = 0;
> > +
> > +       hash_add(hash, &a.node, a.key);
> > +       hash_add(hash, &b.node, b.key);
> > +
> > +       hash_del(&b.node);
> > +       hash_for_each_possible(hash, x, node, b.key) {
> > +               if (x->key == b.key && x->data == b.data)
> > +                       b.visited += 1;
>
> Similarly to above, x->visited += 1 (or ++) is probably better.

Right. Will switch this out here.

>
> > +       }
> > +
> > +       /* The deleted entry should not have been visited. */
> > +       KUNIT_EXPECT_EQ(test, b.visited, 0);
> > +
> > +       hash_del(&a.node);
> > +
> > +       /* The hashtable should be empty. */
> > +       KUNIT_EXPECT_TRUE(test, hash_empty(hash));
> > +}
> > +
> > +static void hashtable_test_hash_for_each(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry entries[3];
> > +       struct hashtable_test_entry *x;
> > +       int bkt, i, j, count;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       /* Initialize a hashtable with three entries. */
> > +       hash_init(hash);
> > +       for (i = 0; i < 3; i++) {
> > +               entries[i].key = i;
> > +               entries[i].data = i + 10;
> > +               entries[i].visited = 0;
> > +               hash_add(hash, &entries[i].node, entries[i].key);
> > +       }
> > +
> > +       count = 0;
> > +       hash_for_each(hash, bkt, x, node) {
> > +               if (x->key >= 0 && x->key < 3)
> > +                       entries[x->key].visited += 1;
>
> Would this be better using an assert to fail the test if we see unexpected keys?
> E.g. like
>   if (x->key < 0 || x->key > 3) KUNIT_ASSERT_FAILURE(test, ...);
>   x->visited++;
>   count++;
> or
>   KUNIT_ASSERT_GE(test, x->key, 0);
>   KUNIT_ASSERT_LT(test, x->key, 3);

Yes, this makes a lot of sense. I will switch out just the if
statements for using assert statements.

>
> > +               count++;
> > +       }
> > +
> > +       /* Should have visited each entry exactly once. */
> > +       KUNIT_EXPECT_EQ(test, count, 3);
> > +       for (j = 0; j < 3; j++)
> > +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> > +}
> > +
> > +static void hashtable_test_hash_for_each_safe(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry entries[3];
> > +       struct hashtable_test_entry *x;
> > +       struct hlist_node *tmp;
> > +       int bkt, i, j, count;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       /* Initialize a hashtable with three entries. */
> > +       hash_init(hash);
> > +       for (i = 0; i < 3; i++) {
> > +               entries[i].key = i;
> > +               entries[i].data = i + 10;
> > +               entries[i].visited = 0;
> > +               hash_add(hash, &entries[i].node, entries[i].key);
> > +       }
> > +
> > +       count = 0;
> > +       hash_for_each_safe(hash, bkt, tmp, x, node) {
> > +               if (x->key >= 0 && x->key < 3) {
> > +                       entries[x->key].visited += 1;
> > +                       hash_del(&entries[x->key].node);
> > +               }
> > +               count++;
> > +       }
> > +
> > +       /* Should have visited each entry exactly once. */
> > +       KUNIT_EXPECT_EQ(test, count, 3);
> > +       for (j = 0; j < 3; j++)
> > +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> > +}
> > +
> > +static void hashtable_test_hash_for_each_possible(struct kunit *test)
> > +{
> > +       struct hashtable_test_entry entries[4];
> > +       struct hashtable_test_entry *x;
> > +       int i, j, count;
> > +       DEFINE_HASHTABLE(hash, 3);
> > +
> > +       /* Initialize a hashtable with three entries with key = 1. */
> > +       hash_init(hash);
> > +       for (i = 0; i < 3; i++) {
> > +               entries[i].key = 1;
> > +               entries[i].data = i;
> > +               entries[i].visited = 0;
> > +               hash_add(hash, &entries[i].node, entries[i].key);
> > +       }
> > +
> > +       /* Add an entry with key = 2. */
> > +       entries[3].key = 2;
> > +       entries[3].data = 3;
> > +       entries[3].visited = 0;
> > +       hash_add(hash, &entries[3].node, entries[3].key);
> > +
> > +       count = 0;
> > +       hash_for_each_possible(hash, x, node, 1) {
> > +               if (x->data >= 0 && x->data < 4)
> > +                       entries[x->data].visited += 1;
> > +               count++;
> > +       }
> > +
> > +       /* Should have visited each entry with key = 1 exactly once. */
> > +       for (j = 0; j < 3; j++)
> > +               KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
> > +
> > +       /* If entry with key = 2 is in the same bucket as the entries with
> > +        * key = 1, check it was visited. Otherwise ensure that only three
> > +        * entries were visited.
> > +        */
> > +       if (hash_min(1, HASH_BITS(hash)) == hash_min(2, HASH_BITS(hash))) {
>
> nit: this feels like we might be a bit too tied to the impl (not sure
> if it'll change anytime soon, but still).
>
> Could we check the bucket using hash_for_each?
> E.g.
>
> // assume we change the keys from {1,2} to {0,1}
> int buckets[2];
> hash_for_each(hash, bkt, x, node) {
>   buckets[x->key] = bkt;
> }
>
> if (buckets[0] == buckets[1]) { // all in the same bucket
>   ...
> } else { ... }

I really like the idea of using hash_for_each to determine the bucket.
I will add this to the test.

>
> > +               KUNIT_EXPECT_EQ(test, count, 4);
> > +               KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
> > +       } else {
> > +               KUNIT_EXPECT_EQ(test, count, 3);
>
> should we also check that entries[3].visited == 0?

Right. Must have been a mistake on my end. Oops.

>
> Daniel

Thanks Daniel!
-Rae
