Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC85735E89C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDMV4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 17:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhDMV4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 17:56:20 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDDC061756
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 14:56:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c18so15369719iln.7
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rpouA4JrTUXzW46yTmnFq2i5W5/FEemBhTDD09OgTEc=;
        b=IAUPW2/2oute27fT+OUOq5d3n4mqZnZl9HNr/eLCFpu8U5bgh4lUlB4LL7vIqjE654
         ICvw8gWlMxgn9NiNGi+IMfkk5JEioaGRscxudfANGamu0c/nwT+NrP/QuJXWo/0WaXfa
         AT7PxiVxaCioIIsCoVZy9lag9LQcD5uQ4WE0hSiqyoio2J/QhnzGV9DfXHf5bKAt6Y3A
         feJoWBDrt50rjy5gqRw+rQwAXDK2u9XCvULRnI5CYIcIJtYWFLey9lmq0BX6ZdeFSjNv
         OVVffASDNJrb/AhgqYZQA+rAQeN4+yKmPE5k7FKimVSOI7xYjDDl3qPftTFoE8vE16xa
         KJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpouA4JrTUXzW46yTmnFq2i5W5/FEemBhTDD09OgTEc=;
        b=mK4HSX2AihDJ2VZMfxE+yRgSSuMNYxrKhuQ7ug5ioM8c7DLE+OMaja2tVFIztd7gtX
         9GoDlv84Hiectrz3ZbklFD5u4PfKIaWHlSLyZQci/5kA2hEAB2c6mSgzQdeVYRdzWAZe
         LCmSdCd4NAxa6J188g6yYlPIdxCp6Jb4Wo4OeK4UqOdIIRb2H+lk21xDAqp7e21LC3ZM
         LqYNFFz1jZ0fnGpY95hIuSgWZNJbInuRCOJJxAofUyi5hdn9YjqrC4UjlNPtxFBVRPSj
         vOPL/8iOqx6KEHnAO7QKX3eaLifDDlEBeg540MUtpwreIOfeNafsDbVVrEOTB5OpREgG
         3S8A==
X-Gm-Message-State: AOAM533InA8uU6NP3wxGqx3+db3PUYR9fGbaYK+IDIM4aC/BZtKdupgH
        EIP37CTeFLW14/JXix5Ise/7yYEAVIGXaPiDdFjaew==
X-Google-Smtp-Source: ABdhPJxqOnIgKRDvWrE+Y4cd/f0oQSq/ST9P9lC3tU1NUezPW4OFiLdoO7wdZcY0gkqjjmKcJQw+NdyREF+qLu9wnc8=
X-Received: by 2002:a92:6011:: with SMTP id u17mr29462637ilb.274.1618350959910;
 Tue, 13 Apr 2021 14:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210413000803.778099-1-dlatypov@google.com> <CABVgOSm7ywx8KNQVLULgCPvJ9tcLsaS3Rk4zkre05bOdk9gfeg@mail.gmail.com>
In-Reply-To: <CABVgOSm7ywx8KNQVLULgCPvJ9tcLsaS3Rk4zkre05bOdk9gfeg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 13 Apr 2021 14:55:48 -0700
Message-ID: <CAGS_qxqL9p+5DSwLu5yVG+cdLOji6B1PHUR9=+mHND2PfgB9XA@mail.gmail.com>
Subject: Re: [PATCH] kunit: add unit test for filtering suites by names
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Apr 13, 2021 at 8:08 AM Daniel Latypov <dlatypov@google.com> wrot=
e:
> >
> > This adds unit tests for kunit_filter_subsuite() and
> > kunit_filter_suites().
> >
> > Note: what the executor means by "subsuite" is the array of suites
> > corresponding to each test file.
> >
> > This patch lightly refactors executor.c to avoid the use of global
> > variables to make it testable.
> > It also includes a clever `kfree_at_end()` helper that makes this test
> > easier to write than it otherwise would have been.
> >
> > Tested by running just the new tests using itself
> > $ ./tools/testing/kunit/kunit.py run '*exec*'
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> I really like this test, thanks.
>
> A few small notes below, including what I think is a missing
> kfree_at_end() call.
>
> Assuming that one issue is fixed (or I'm mistaken):
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> > ---
> >  lib/kunit/executor.c      |  26 ++++----
> >  lib/kunit/executor_test.c | 132 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 147 insertions(+), 11 deletions(-)
> >  create mode 100644 lib/kunit/executor_test.c
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 15832ed44668..96a4ae983786 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -19,7 +19,7 @@ MODULE_PARM_DESC(filter_glob,
> >                 "Filter which KUnit test suites run at boot-time, e.g. =
list*");
> >
> >  static struct kunit_suite * const *
> > -kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
> > +kunit_filter_subsuite(struct kunit_suite * const * const subsuite, con=
st char *filter_glob)
> >  {
> >         int i, n =3D 0;
> >         struct kunit_suite **filtered;
> > @@ -52,19 +52,14 @@ struct suite_set {
> >         struct kunit_suite * const * const *end;
> >  };
> >
> > -static struct suite_set kunit_filter_suites(void)
> > +static struct suite_set kunit_filter_suites(const struct suite_set *su=
ite_set,
> > +                                           const char *filter_glob)
> >  {
> >         int i;
> >         struct kunit_suite * const **copy, * const *filtered_subsuite;
> >         struct suite_set filtered;
> >
> > -       const size_t max =3D __kunit_suites_end - __kunit_suites_start;
> > -
> > -       if (!filter_glob) {
> > -               filtered.start =3D __kunit_suites_start;
> > -               filtered.end =3D __kunit_suites_end;
> > -               return filtered;
> > -       }
> > +       const size_t max =3D suite_set->end - suite_set->start;
> >
> >         copy =3D kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL=
);
> >         filtered.start =3D copy;
> > @@ -74,7 +69,7 @@ static struct suite_set kunit_filter_suites(void)
> >         }
> >
> >         for (i =3D 0; i < max; ++i) {
> > -               filtered_subsuite =3D kunit_filter_subsuite(__kunit_sui=
tes_start[i]);
> > +               filtered_subsuite =3D kunit_filter_subsuite(suite_set->=
start[i], filter_glob);
> >                 if (filtered_subsuite)
> >                         *copy++ =3D filtered_subsuite;
> >         }
> > @@ -98,8 +93,13 @@ static void kunit_print_tap_header(struct suite_set =
*suite_set)
> >  int kunit_run_all_tests(void)
> >  {
> >         struct kunit_suite * const * const *suites;
> > +       struct suite_set suite_set =3D {
> > +               .start =3D __kunit_suites_start,
> > +               .end =3D __kunit_suites_end,
> > +       };
> >
> > -       struct suite_set suite_set =3D kunit_filter_suites();
> > +       if (filter_glob)
> > +               suite_set =3D kunit_filter_suites(&suite_set, filter_gl=
ob);
> >
> >         kunit_print_tap_header(&suite_set);
> >
> > @@ -115,4 +115,8 @@ int kunit_run_all_tests(void)
> >         return 0;
> >  }
> >
> > +#if IS_BUILTIN(CONFIG_KUNIT_TEST)
> > +#include "executor_test.c"
> > +#endif
> > +
> >  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > new file mode 100644
> > index 000000000000..8e925395beeb
> > --- /dev/null
> > +++ b/lib/kunit/executor_test.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for the KUnit executor.
> > + *
> > + * Copyright (C) 2021, Google LLC.
> > + * Author: Daniel Latypov <dlatypov@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +
> > +static void kfree_at_end(struct kunit *test, const void *to_free);
> > +static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> > +                                           const char *suite_name);
> > +
> > +static void filter_subsuite_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[3] =3D {NULL, NULL, NULL};
> > +       struct kunit_suite * const *filtered;
> > +
> > +       subsuite[0] =3D alloc_fake_suite(test, "suite1");
> > +       subsuite[1] =3D alloc_fake_suite(test, "suite2");
> > +
> > +       /* Want: suite1, suite2, NULL -> suite2, NULL */
> > +       filtered =3D kunit_filter_subsuite(subsuite, "suite2*");
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> > +       kfree_at_end(test, filtered);
> > +
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> > +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suit=
e2");
>
> Is it worth testing that filtered[0] =3D=3D subsuite[1], not just the
> name? (I suspect it doesn't really matter, but that seems to be what's
> happening in filter_suites_test() below.)

I'll update filter_suites_test() to check the name instead as well.
My reason reason for preferring checking the name is because if we
ever support filtering on test names as well as suites, then the suite
pointers will no longer be unchanged.

Semi-rant about why I didn't do that before in filter_suites_test():
The intuitive approach
  KUNIT_EXPECT_PTR_EQ(test, filtered.start[0][0], subsuites[0][0]);
fails to compile with a very uninformative compiler error, see [1]
  KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite=
0");
_does_ compile, but is ugly.

[1] useless compile error due to how the kunit expect macros are set up:
ERROR:root:In file included from ../lib/kunit/executor.c:3:
../lib/kunit/executor_test.c: In function =E2=80=98filter_suites_test=E2=80=
=99:
../include/kunit/test.h:1132:24: error: invalid initializer
 1132 |  typeof(left) __left =3D (left);            \
      |                        ^
../include/kunit/test.h:1155:2: note: in expansion of macro
=E2=80=98KUNIT_BINARY_STR_ASSERTION=E2=80=99
 1155 |  KUNIT_BINARY_STR_ASSERTION(test,           \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
../include/kunit/test.h:1162:2: note: in expansion of macro
=E2=80=98KUNIT_BINARY_STR_EQ_MSG_ASSERTION=E2=80=99
 1162 |  KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,           \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/kunit/test.h:1446:2: note: in expansion of macro
=E2=80=98KUNIT_BINARY_STR_EQ_ASSERTION=E2=80=99
 1446 |  KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right=
)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/kunit/executor_test.c:87:2: note: in expansion of macro
=E2=80=98KUNIT_EXPECT_STREQ=E2=80=99
   87 |  KUNIT_EXPECT_STREQ(test, filtered.start[0][0]->name, "suite0");
      |  ^~~~~~~~~~~~~~~~~~

Root cause: kunit_suite.name is a const char[256] and the expect
macros don't play kindly with arrays :(
Note: nowhere in the error output does it mention any of the relevant types=
!
It's just complaining that you can't initialize array variables with
anything besides a string literal or {}-enclosed expression.

>
> > +
> > +       KUNIT_EXPECT_FALSE(test, filtered[1]);
> > +}
> > +
> > +static void filter_subsuite_to_empty_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[3] =3D {NULL, NULL, NULL};
> > +       struct kunit_suite * const *filtered;
> > +
> > +       subsuite[0] =3D alloc_fake_suite(test, "suite1");
> > +       subsuite[1] =3D alloc_fake_suite(test, "suite2");
> > +
> > +       filtered =3D kunit_filter_subsuite(subsuite, "not_found");
> > +       kfree_at_end(test, filtered); /* just in case */
> > +
> > +       KUNIT_EXPECT_FALSE_MSG(test, filtered,
> > +                              "should be NULL to indicate no match");
> > +}
> > +
> > +static void kfree_subsuites_at_end(struct kunit *test, struct suite_se=
t *suite_set)
> > +{
> > +       struct kunit_suite * const * const *suites;
> > +
> > +       for (suites =3D suite_set->start; suites < suite_set->end; suit=
es++)
> > +               kfree_at_end(test, *suites);
> > +}
> > +
> > +static void filter_suites_test(struct kunit *test)
> > +{
> > +       /* Suites per-file are stored as a NULL terminated array */
> > +       struct kunit_suite *subsuites[2][2] =3D {
> > +               {NULL, NULL},
> > +               {NULL, NULL},
> > +       };
> > +       /* Match the memory layout of suite_set */
> > +       struct kunit_suite * const * const suites[2] =3D {
> > +               subsuites[0], subsuites[1],
> > +       };
> > +
> > +       const struct suite_set suite_set =3D {
> > +               .start =3D suites,
> > +               .end =3D suites + 2,
> > +       };
> > +       struct suite_set filtered =3D {.start =3D NULL, .end =3D NULL};
> > +
> > +       /* Emulate two files, each having one suite */
> > +       subsuites[0][0] =3D alloc_fake_suite(test, "suite0");
> > +       subsuites[1][0] =3D alloc_fake_suite(test, "suite1");
> > +
> > +       /* Filter out suite1 */
> > +       filtered =3D kunit_filter_suites(&suite_set, "suite0");
> > +       kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs =
without leaking */
>
> Do we also need to kfree_at_end(test, &filtered.start) here?

Ah, I meant to have that in kfree_subsuites_at_end().
Added the call there.

>
> > +       KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t=
) 1);
> > +
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
> > +       KUNIT_EXPECT_PTR_EQ(test, filtered.start[0][0], subsuites[0][0]=
);
> > +}
> > +
> > +static struct kunit_case executor_test_cases[] =3D {
> > +       KUNIT_CASE(filter_subsuite_test),
> > +       KUNIT_CASE(filter_subsuite_to_empty_test),
> > +       KUNIT_CASE(filter_suites_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite executor_test_suite =3D {
> > +       .name =3D "kunit_executor_test",
> > +       .test_cases =3D executor_test_cases,
> > +};
> > +
> > +kunit_test_suites(&executor_test_suite);
> > +
> > +/* Test helpers */
> > +
> > +static void kfree_res_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->data);
> > +}
> > +
> > +/* Use the resource API to register a call to kfree(to_free).
> > + * Since we never actually use the resource, it's safe to use on const=
 data.
> > + */
> > +static void kfree_at_end(struct kunit *test, const void *to_free)
> > +{
> > +       /* kfree() handles NULL already, but avoid allocating a no-op c=
leanup. */
> > +       if (IS_ERR_OR_NULL(to_free))
> > +               return;
> > +       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KE=
RNEL,
> > +                                    (void *)to_free);
> > +}
>
> This actually seems useful enough to move out of this test and have as
> part of the KUnit framework proper. Admittedly, I normally am very
> sceptical about doing this when there's only one user, but this does
> seem more obviously useful than most things. As a bonus, it could
> reuse the kunit_kmalloc_free() function, rather than having its own
> kfree_res_free() helper.

I'm still a bit more on the fence about it, leaning towards not adding
it into KUnit.
I'm not too sure how much a plain `kfree()` would be needed outside of
tests, and I know there's plenty of variant xxxfree(void *) functions.

So a more generic form like [2] might be useful, but...

By my count, we have ~100 (this is >=3D the actual # since it double
counts decls+defs)
$ ag --nomultiline 'void .*free\((const )?void \*[^,]+\)' | wc -l
139

Sample output to make sure the regex works:
$ ag --nomultiline 'void .*free\((const )?void \*[^,]+\)' | head -5
arch/parisc/boot/compressed/misc.c:213:void free(void *ptr)
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:59:void
mpc85xx_cache_sram_free(void *ptr)
arch/powerpc/boot/simple_alloc.c:83:static void simple_free(void *ptr)
arch/powerpc/boot/ops.h:222:static inline void free(void *ptr)
arch/powerpc/include/asm/fsl_85xx_cache_sram.h:31:extern void
mpc85xx_cache_sram_free(void *ptr);

But hmm, it seems like non-const is far more common than `const void *`.
Looking at a few, they really should be `const void *`, sigh...
We could cast away the differences, but that feels a bit iffy in the
case where the function might actually need them to be non-const.

So to do that "properly", I think we need a const and non-const
version of the interface?
If so, I don't think that's justified quite yet.

[2] more generic interface
struct kunit_cleanup_res {
        void (*cleanup)(const void *);
        const void *data;
};

static void kunit_cleanup_res(struct kunit_resource *res) {
        struct kunit_cleanup_res *c =3D res->data;
        c->cleanup(c->data);
};

static void kunit_register_cleanup(struct kunit *test, void
(*cleanup)(const void *), const void *data)
{
        struct kunit_cleanup_res *res;

        if (IS_ERR_OR_NULL(data))
                return;

        res =3D kunit_kmalloc(test, sizeof(*res), GFP_KERNEL);
        res->cleanup =3D cleanup;
        res->data =3D data;

        kunit_alloc_and_get_resource(test, NULL, kunit_cleanup_res,
GFP_KERNEL, res);
}

static void kfree_at_end(struct kunit *test, const void *to_free)
{
        kunit_register_cleanup(test, kfree, to_free);

}

>
> > +
> > +static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> > +                                           const char *suite_name)
> > +{
> > +       struct kunit_suite *suite;
> > +
> > +       /* We normally never expect to allocate suites, hence the non-c=
onst cast. */
> > +       suite =3D kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> > +       strncpy((char *)suite->name, suite_name, sizeof(suite->name));
> > +
> > +       return suite;
> > +}
> >
> > base-commit: 1678e493d530e7977cce34e59a86bb86f3c5631e
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
