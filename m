Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0E228C87
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 01:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgGUXMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 19:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgGUXMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 19:12:32 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F302C0619DB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 16:12:32 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g6so31701ybo.11
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WaWlgf4cpkrkN1UMreBMB3ceQDo50R6RSy+/m31Oe1g=;
        b=Ub1jwV1sv6dQJyicuE5RmhHVUzNJ2xnJOjPndDoFWji1wKBvOq/1D2HaU5x2iP0OfS
         UoZrp3Rkp1Lqa3Dld/NiHMs3o6sksL4tXovtkajBm8kViWJxzXMt8USj8w7w5hrn+99t
         dOrGelBBFxujA3w4Buj0cdM1SIzxZpHfLHgTiGNX2rH2dArB1uqudS3QlZsZ3d51aX9b
         qFpjRRg68o+q+7GD8WN4vVUQ6cjPegnLeBT+yULtuDBW/X53O3YZT/YcqCLx4um+1im+
         7P6IGbB3Io+7KJZAt7l2dZAEQ2oOPtd95b5HQ8zfzh+kxbxAnBbIA14GSx07AbVdrv1f
         uuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaWlgf4cpkrkN1UMreBMB3ceQDo50R6RSy+/m31Oe1g=;
        b=Wv1Q1OQdJQ4rbCt6ra7L31dwe66En64k78s2aeXRkYXHcUSQYE2La0OOPS8zoyYPd5
         7u7eO/3FhKhNSjnSOGkMPvow58RE+P8P8CFUobVmUiQVShsIrMhi4Gm8dF5AoNaeBSTU
         o0KNTjooOGcsvpEbCom09X74Y0GG78USE3pUGH6uY64I4NGUS/TTi32sUWeY5fYfUjgT
         331m+Du536E1WCI/ahFXLxsbev/3Sr1FcKHLd5qVPcdN3LwWKeKk6t62m4HZ/6Hsf3YN
         zQMKvQCqNomf/9OeiNhV28Mpt941sIeIlLsaNe2EzE4x4ZSf1HbpdGprPJAwCKpfu8aB
         IcuQ==
X-Gm-Message-State: AOAM532ycp3pyrT9LJSqEOKFcYOROP7KXzXdW84efM/JeJz8Caf9oYJH
        1ySfHuOZ6S2NyKBxpow/OOY7kfLSjAFaBAmgdXioQcMg9HO67STE
X-Google-Smtp-Source: ABdhPJwZ5W1L+xjjoM68uiUGFzzmww+gLj5e0d4K01rPds/oqmkm0/snzqdd56skbg1DFONtB3jHt/GM99WxdXXJzn8=
X-Received: by 2002:a25:bb0d:: with SMTP id z13mr43849156ybg.488.1595373151227;
 Tue, 21 Jul 2020 16:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
In-Reply-To: <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Tue, 21 Jul 2020 20:11:54 -0300
Message-ID: <CADQ6JjU9ou9kaiPhJgTnJ=rbyxibPJuDx5__jBxvKu6tXFfu2A@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 7:19 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> On Tue, Jul 21, 2020 at 4:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jul 21, 2020 at 02:46:54PM -0300, Vitor Massaru Iha wrote:
> > > This adds the conversion of the runtime tests of test_user_copy fuctions,
> > > from `lib/test_user_copy.c`to KUnit tests.
> > >
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > ---
> > > v2:
> > >     * splitted patch in 3:
> > >         - Allows to install and load modules in root filesystem;
> > >         - Provides an userspace memory context when tests are compiled
> > >           as module;
> > >         - Convert test_user_copy to KUnit test;
> > >     * removed entry for CONFIG_TEST_USER_COPY;
> > >     * replaced pr_warn to KUNIT_EXPECT_FALSE_MSG in test macro to
> > >       decrease the diff;
> > > v3:
> > >     * rebased with last kunit branch
> > >     * Please apply this commit from kunit-fixes:
> > >         3f37d14b8a3152441f36b6bc74000996679f0998
> > >       And these from patchwork:
> > >         https://patchwork.kernel.org/patch/11676331/
> > >         https://patchwork.kernel.org/patch/11676335/
> > > ---
> > >  lib/Kconfig.debug                           | 28 ++++++++------
> > >  lib/Makefile                                |  2 +-
> > >  lib/{test_user_copy.c => user_copy_kunit.c} | 42 +++++++++------------
> > >  3 files changed, 35 insertions(+), 37 deletions(-)
> > >  rename lib/{test_user_copy.c => user_copy_kunit.c} (91%)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 9ad9210d70a1..f699a3624ae7 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2078,18 +2078,6 @@ config TEST_VMALLOC
> > >
> > >         If unsure, say N.
> > >
> > > -config TEST_USER_COPY
> > > -     tristate "Test user/kernel boundary protections"
> > > -     depends on m
> > > -     help
> > > -       This builds the "test_user_copy" module that runs sanity checks
> > > -       on the copy_to/from_user infrastructure, making sure basic
> > > -       user/kernel boundary testing is working. If it fails to load,
> > > -       a regression has been detected in the user/kernel memory boundary
> > > -       protections.
> > > -
> > > -       If unsure, say N.
> > > -
> > >  config TEST_BPF
> > >       tristate "Test BPF filter functionality"
> > >       depends on m && NET
> > > @@ -2154,6 +2142,22 @@ config SYSCTL_KUNIT_TEST
> > >
> > >         If unsure, say N.
> > >
> > > +config USER_COPY_KUNIT
> > > +     tristate "KUnit Test for user/kernel boundary protections"
> > > +     depends on KUNIT
> > > +     depends on m
> > > +     help
> > > +       This builds the "user_copy_kunit" module that runs sanity checks
> > > +       on the copy_to/from_user infrastructure, making sure basic
> > > +       user/kernel boundary testing is working. If it fails to load,
> > > +       a regression has been detected in the user/kernel memory boundary
> > > +       protections.
> > > +
> > > +       For more information on KUnit and unit tests in general please refer
> > > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > > +
> > > +       If unsure, say N.
> > > +
> > >  config LIST_KUNIT_TEST
> > >       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
> > >       depends on KUNIT
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index b1c42c10073b..8c145f85accc 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> > >  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> > >  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> > >  obj-$(CONFIG_TEST_SORT) += test_sort.o
> > > -obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> > >  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
> > >  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
> > >  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
> > > @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> > >  # KUnit tests
> > >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> > >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> > > +obj-$(CONFIG_USER_COPY_KUNIT) += user_copy_kunit.o
> > > diff --git a/lib/test_user_copy.c b/lib/user_copy_kunit.c
> > > similarity index 91%
> > > rename from lib/test_user_copy.c
> > > rename to lib/user_copy_kunit.c
> > > index 5ff04d8fe971..a10ddd15b4cd 100644
> > > --- a/lib/test_user_copy.c
> > > +++ b/lib/user_copy_kunit.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/vmalloc.h>
> > > +#include <kunit/test.h>
> > >
> > >  /*
> > >   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> > > @@ -35,7 +36,7 @@
> > >  ({                                                                   \
> > >       int cond = (condition);                                         \
> > >       if (cond)                                                       \
> > > -             pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);     \
> > > +             KUNIT_EXPECT_FALSE_MSG(test, cond, msg, ##__VA_ARGS__); \
> >
> > I'm surprised any of this compiles with both a macro and arg named
> > "test". :) Can you change the arg to something with more clarity?
> > "context" or "kunit" seems better.
>
> It will be out of the standard of the other tests in KUnit, but I agree that
> I should not use the same name "test" in the argument and in the name
> of the macro.
> I'll replace it with "context" instead of "test" in arg.
>
> >
> > >       cond;                                                           \
> > >  })
> > >
> > > @@ -44,7 +45,7 @@ static bool is_zeroed(void *from, size_t size)
> > >       return memchr_inv(from, 0x0, size) == NULL;
> > >  }
> > >
> > > -static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> > > +static int test_check_nonzero_user(struct kunit *test, char *kmem, char __user *umem, size_t size)
> > >  {
> > >       int ret = 0;
> > >       size_t start, end, i, zero_start, zero_end;
> > > @@ -102,7 +103,7 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> > >       return ret;
> > >  }
> > >
> > > -static int test_copy_struct_from_user(char *kmem, char __user *umem,
> > > +static int test_copy_struct_from_user(struct kunit *test, char *kmem, char __user *umem,
> > >                                     size_t size)
> > >  {
> > >       int ret = 0;
> > > @@ -177,7 +178,7 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
> > >       return ret;
> > >  }
> > >
> > > -static int __init test_user_copy_init(void)
> > > +static void user_copy_test(struct kunit *test)
> > >  {
> > >       int ret = 0;
> > >       char *kmem;
> > > @@ -192,16 +193,14 @@ static int __init test_user_copy_init(void)
> > >  #endif
> > >
> > >       kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
> > > -     if (!kmem)
> > > -             return -ENOMEM;
> > > +     KUNIT_EXPECT_FALSE_MSG(test, kmem == NULL, "kmalloc failed");
> >
> > This would need to be an ASSERT, yes?
>
> Yep, I'll fix it.
>
> >
> > >
> > >       user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
> > >                           PROT_READ | PROT_WRITE | PROT_EXEC,
> > >                           MAP_ANONYMOUS | MAP_PRIVATE, 0);
> > >       if (user_addr >= (unsigned long)(TASK_SIZE)) {
> > > -             pr_warn("Failed to allocate user memory\n");
> > >               kfree(kmem);
> > > -             return -ENOMEM;
> > > +             KUNIT_FAIL(test, "Failed to allocate user memory");
> > >       }
> >
> > Why FAIL instead of ASSERT?
>
> I did it this way so I wouldn't have to test twice if I had a memory
> allocation problem,
> once in the "if" and once in the ASSERT, so the memory of the other
> kmalloc is freed
> in case of memory allocation error in this memory allocation.

Hm, In this case the test needs to stop, I'll fix it.

>
> >
> > >
> > >       usermem = (char __user *)user_addr;
> > > @@ -245,9 +244,9 @@ static int __init test_user_copy_init(void)
> > >  #undef test_legit
> > >
> > >       /* Test usage of check_nonzero_user(). */
> > > -     ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> > > +     ret |= test_check_nonzero_user(test, kmem, usermem, 2 * PAGE_SIZE);
> > >       /* Test usage of copy_struct_from_user(). */
> > > -     ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> > > +     ret |= test_copy_struct_from_user(test, kmem, usermem, 2 * PAGE_SIZE);
> > >
> > >       /*
> > >        * Invalid usage: none of these copies should succeed.
> > > @@ -309,23 +308,18 @@ static int __init test_user_copy_init(void)
> > >
> > >       vm_munmap(user_addr, PAGE_SIZE * 2);
> > >       kfree(kmem);
> > > -
> > > -     if (ret == 0) {
> > > -             pr_info("tests passed.\n");
> > > -             return 0;
> > > -     }
> > > -
> > > -     return -EINVAL;
> >
> > Does KUnit provide a end-of-test summary now?
>
> When you talk about end-of-test summary, is it what is written in
> dmesg and not the kunit-tool?
>
> >
> > >  }
> > >
> > > -module_init(test_user_copy_init);
> > > -
> > > -static void __exit test_user_copy_exit(void)
> > > -{
> > > -     pr_info("unloaded.\n");
> > > -}
> > > +static struct kunit_case user_copy_test_cases[] = {
> > > +     KUNIT_CASE(user_copy_test),
> > > +     {}
> > > +};
> > >
> > > -module_exit(test_user_copy_exit);
> > > +static struct kunit_suite user_copy_test_suite = {
> > > +     .name = "user_copy",
> > > +     .test_cases = user_copy_test_cases,
> > > +};
> > >
> > > +kunit_test_suites(&user_copy_test_suite);
> > >  MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
> > >  MODULE_LICENSE("GPL");
> > >
> > > base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> > > --
> > > 2.26.2
> > >
> >
> > Otherwise, yes, looking good.
> >
> > --
> > Kees Cook
>
> Thanks for the review!
