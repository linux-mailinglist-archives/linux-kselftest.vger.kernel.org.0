Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29C117C93D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFX6p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 18:58:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43088 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFX6o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 18:58:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id v9so4275111wrf.10
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Mar 2020 15:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GFRyQqmQIECMrJNabXAzRqSAvtGf9JYWLTOf7sH0Jk=;
        b=IBcp+BhHZabicWaeude6cQMd2ruYXje/NzKBNOrqqB9wSfAuoH3Lz6FwC4/Kh9ag+C
         XvA7CtjN57RYdkXzqdzp9R1LkPEHt1nezdGMMcLI3fkVBFAjudofK/3zgAql9xoEPrz+
         uWTGHr/M4bzPvZ9pNiJQqITg7W6aAcCSqJoWCplgzKm14vhEohNmMKZwiSWBWd6PFELi
         3KUdDpgSaIs8Eugdw4xmNVJchs9nsRPemOErwS1LYGct8hwEEzlqiNMqPg9Ojzts/YKB
         h7ce5nr/R/RmrfCGc8+JZw8zkD2lIHWC0owha+wGGvly5KoGMMWxwd8/J23ESGP8NHoH
         mM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GFRyQqmQIECMrJNabXAzRqSAvtGf9JYWLTOf7sH0Jk=;
        b=TlDw29xN9dyiXpWyV9DClKi5s6r/+P2FihS218b/F4T+6wFCGd2EgKzrqFn7OpN0OT
         m9IjTIuwx2E5lbCe9jqRVmvouPk/GMzmGt7keAO8X8SoGyzaIlMX9Mpe6EC1Oui9NGRu
         LRurWE70bidUQ7RsLvk4/w1vwoXCcKETC2oh1aUySH4sTBfOJNXQDLD/cnhj6yJVws3M
         zTdnJTuXezsmYKWtcckisEeKsAHiyYjeYTByitedIjwB4LmSMnF5BEhDtxh9Gp4ojt+A
         UKpbzuuuQCs2chz56oBqWu/TmkYDyMVlZBJQtK8E4Em/Qt5GhiICzwpOcu/8RTSlAXBm
         nAFQ==
X-Gm-Message-State: ANhLgQ0qH2K0aloHIQ57SISlBWusny61axAUwFWXmX/HdHIZXZAbphsX
        8+9mMFr7IaH9pSmGIF/cT90s22FROGvZltsh5DAg1Q==
X-Google-Smtp-Source: ADFU+vsIRjnTOPY+bMrihSsktETTQQtVUy8pYeLdAR6GT6o+JDLFYTFWQXmwaZtn4kvjWDpdWgwyU+6e96dcGhIXpGU=
X-Received: by 2002:adf:ee48:: with SMTP id w8mr6131055wro.290.1583539119611;
 Fri, 06 Mar 2020 15:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 6 Mar 2020 15:58:28 -0800
Message-ID: <CAKFsvUJtNNDohCp30ytkSRoS03z7m49nKjQ3Nhzo5gbfVzKdNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 6:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> .On Thu, Feb 27, 2020 at 3:44 AM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> >
> > Transfer all previous tests for KASAN to KUnit so they can be run
> > more easily. With proper KASAN integration into KUnit, developers can
> > run these tests with their other KUnit tests and see "pass" or "fail"
> > with the appropriate KASAN report instead of needing to parse each KASAN
> > report to test KASAN functionalities.
> >
> > Stack tests do not work in UML so those tests are protected inside an
> > "#if (CONFIG_KASAN_STACK == 1)" so this only runs if stack
> > instrumentation is enabled.
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > ---

> >
> > -static noinline void __init kasan_bitops(void)
> > +static noinline void kasan_bitops(void)
> >  {
> >         /*
> >          * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> > @@ -676,70 +598,52 @@ static noinline void __init kasan_bitops(void)
> >          * below accesses are still out-of-bounds, since bitops are defined to
> >          * operate on the whole long the bit is in.
> >          */
> > -       pr_info("out-of-bounds in set_bit\n");
> >         set_bit(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in __set_bit\n");
> >         __set_bit(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in clear_bit\n");
> >         clear_bit(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in __clear_bit\n");
> >         __clear_bit(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in clear_bit_unlock\n");
> >         clear_bit_unlock(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in __clear_bit_unlock\n");
> >         __clear_bit_unlock(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in change_bit\n");
> >         change_bit(BITS_PER_LONG, bits);
> >
> > -       pr_info("out-of-bounds in __change_bit\n");
> >         __change_bit(BITS_PER_LONG, bits);
> >
> >         /*
> >          * Below calls try to access bit beyond allocated memory.
> >          */
> > -       pr_info("out-of-bounds in test_and_set_bit\n");
> >         test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in __test_and_set_bit\n");
> >         __test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in test_and_set_bit_lock\n");
> >         test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in test_and_clear_bit\n");
> >         test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in __test_and_clear_bit\n");
> >         __test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in test_and_change_bit\n");
> >         test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in __test_and_change_bit\n");
> >         __test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> > -       pr_info("out-of-bounds in test_bit\n");
> >         (void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >
> >  #if defined(clear_bit_unlock_is_negative_byte)
> > -       pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
> >         clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, bits);
> >  #endif
> >         kfree(bits);
> >  }
> >
> > -static noinline void __init kmalloc_double_kzfree(void)
> > +static noinline void kmalloc_double_kzfree(void)
>
> Since it seems we will need v2, it will help if you move these
> mechanical diffs to a separate patch. I mean removal of __init and
> pr_info. These produce lots of changes and it's hard to separate out
> more meaningful changes from this mechanical noise.
>
While making changes, I have edited enough where I don't think
separating out the __init and pr_info changes will make much of a
difference with readability of the patch. Making
KUNIT_EXPECT_KASAN_FAIL local to the test requires changes in those
same lines. If this is still a problem in v2 and you see a clean way
to separate the changes, I'd be happy to fix it for the next version.

> >  {
> >         char *ptr;
> >         size_t size = 16;
> >
> > -       pr_info("double-free (kzfree)\n");
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         if (!ptr) {
> >                 pr_err("Allocation failed\n");
> > @@ -750,29 +654,130 @@ static noinline void __init kmalloc_double_kzfree(void)
> >         kzfree(ptr);
> >  }
> >
> > -#ifdef CONFIG_KASAN_VMALLOC
> > -static noinline void __init vmalloc_oob(void)
> > +static void kunit_test_oob(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_right());
>
> I think the 2 patches need to be reordered. This
> KUNIT_EXPECT_KASAN_FAIL is introduced only in the next patch. This
> will break build during bisections.
>
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_left());
>
> I am wondering if it makes sense to have the "KASAN_FAIL" part be part
> of the test itself. It will make the test and assertion local to each
> other. I hope later we will add some negative tests as well (without
> kasan errors), then people will start copy-pasting these macros and
> it's possible I copy-paste macro that checks that the test does not
> produce kasan error for my test, which I actually want the macro that
> checks for report. Then if my test does not fail, it will be
> unnoticed. I may be good to have assertion local to the test itself.
> Thoughts?
>
Absolutely! I don't think I fully understood this comment in my first
response, but as I mentioned above I have been making the
KUNIT_EXPECT_KASAN_FAIL local to each test. I'll send out v2 soon but
just as an example, this is what kmalloc_oob_right() will look like:
static void kmalloc_oob_right(struct kunit *test)
{
char *ptr;
size_t size = 123;

ptr = kmalloc(size, GFP_KERNEL);
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);

KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'x');
kfree(ptr);
}

This way, the expectation is for the exact condition that is expected
to cause the failure, and the ASSERT has replaced
         if (!ptr) {
                 pr_err("Allocation failed\n");
         }
This will cause the test case to fail and immediately abort if ptr is NULL.

> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_node_oob_right());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_large_oob_right());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_krealloc_more());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_krealloc_less());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_16());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_in_memset());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_memset_2());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_memset_4());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_memset_8());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_oob_memset_16());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_oob());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_global_oob());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, ksize_unpoisons_memory());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_memchr());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_memcmp());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_strings());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_bitops());
> > +#ifdef CONFIG_SLUB
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_pagealloc_oob_right());
> > +#endif /* CONFIG_SLUB */
> > +
> > +#if (CONFIG_KASAN_STACK == 1)
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_stack_oob());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_alloca_oob_right());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_alloca_oob_left());
> > +#endif /*CONFIG_KASAN_STACK*/
> > +}
> > +
> > +static void kunit_test_uaf(struct kunit *test)
> > +{
> > +#ifdef CONFIG_SLUB
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_pagealloc_uaf());
> > +#endif
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_uaf());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_uaf_memset());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_uaf2());
> > +}
> > +
> > +static void kunit_test_invalid_free(struct kunit *test)
> >  {
> > -       void *area;
> > +#ifdef CONFIG_SLUB
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_pagealloc_invalid_free());
> > +#endif
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_invalid_free());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_double_free());
> > +       KUNIT_EXPECT_KASAN_FAIL(test, kmalloc_double_kzfree());
> > +}
> >
> > -       pr_info("vmalloc out-of-bounds\n");
> > +static void kunit_test_false_positives(struct kunit *test)
> > +{
> > +       kfree_via_page();
> > +       kfree_via_phys();
> > +}
> >
> > -       /*
> > -        * We have to be careful not to hit the guard page.
> > -        * The MMU will catch that and crash us.
> > -        */
> > -       area = vmalloc(3000);
> > -       if (!area) {
> > -               pr_err("Allocation failed\n");
> > +static void kunit_test_memcg(struct kunit *test)
> > +{
> > +       memcg_accounted_kmem_cache();
> > +}
> > +
> > +static struct kunit_case kasan_kunit_test_cases[] = {
> > +       KUNIT_CASE(kunit_test_oob),
> > +       KUNIT_CASE(kunit_test_uaf),
> > +       KUNIT_CASE(kunit_test_invalid_free),
> > +       KUNIT_CASE(kunit_test_false_positives),
> > +       KUNIT_CASE(kunit_test_memcg),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite kasan_kunit_test_suite = {
> > +       .name = "kasan_kunit_test",
> > +       .test_cases = kasan_kunit_test_cases,
> > +};
> > +
> > +kunit_test_suite(kasan_kunit_test_suite);
> > +
> > +#if IS_MODULE(CONFIG_TEST_KASAN)
> > +static noinline void __init copy_user_test(void)
> > +{
> > +       char *kmem;
> > +       char __user *usermem;
> > +       size_t size = 10;
> > +       int unused;
> > +
> > +       kmem = kmalloc(size, GFP_KERNEL);
> > +       if (!kmem)
> > +               return;
> > +
> > +       usermem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE,
> > +                           PROT_READ | PROT_WRITE | PROT_EXEC,
> > +                           MAP_ANONYMOUS | MAP_PRIVATE, 0);
> > +       if (IS_ERR(usermem)) {
> > +               pr_err("Failed to allocate user memory\n");
> > +               kfree(kmem);
> >                 return;
> >         }
> >
> > -       ((volatile char *)area)[3100];
> > -       vfree(area);
> > +       pr_info("out-of-bounds in copy_from_user()\n");
> > +       unused = copy_from_user(kmem, usermem, size + 1);
> > +
> > +       pr_info("out-of-bounds in copy_to_user()\n");
> > +       unused = copy_to_user(usermem, kmem, size + 1);
> > +
> > +       pr_info("out-of-bounds in __copy_from_user()\n");
> > +       unused = __copy_from_user(kmem, usermem, size + 1);
> > +
> > +       pr_info("out-of-bounds in __copy_to_user()\n");
> > +       unused = __copy_to_user(usermem, kmem, size + 1);
> > +
> > +       pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> > +       unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
> > +
> > +       pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> > +       unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
> > +
> > +       pr_info("out-of-bounds in strncpy_from_user()\n");
> > +       unused = strncpy_from_user(kmem, usermem, size + 1);
> > +
> > +       vm_munmap((unsigned long)usermem, PAGE_SIZE);
> > +       kfree(kmem);
> >  }
> > -#else
> > -static void __init vmalloc_oob(void) {}
> > -#endif
> >
> >  static int __init kmalloc_tests_init(void)
> >  {
> > @@ -782,44 +787,7 @@ static int __init kmalloc_tests_init(void)
> >          */
> >         bool multishot = kasan_save_enable_multi_shot();
> >
> > -       kmalloc_oob_right();
> > -       kmalloc_oob_left();
> > -       kmalloc_node_oob_right();
> > -#ifdef CONFIG_SLUB
> > -       kmalloc_pagealloc_oob_right();
> > -       kmalloc_pagealloc_uaf();
> > -       kmalloc_pagealloc_invalid_free();
> > -#endif
> > -       kmalloc_large_oob_right();
> > -       kmalloc_oob_krealloc_more();
> > -       kmalloc_oob_krealloc_less();
> > -       kmalloc_oob_16();
> > -       kmalloc_oob_in_memset();
> > -       kmalloc_oob_memset_2();
> > -       kmalloc_oob_memset_4();
> > -       kmalloc_oob_memset_8();
> > -       kmalloc_oob_memset_16();
> > -       kmalloc_uaf();
> > -       kmalloc_uaf_memset();
> > -       kmalloc_uaf2();
> > -       kfree_via_page();
> > -       kfree_via_phys();
> > -       kmem_cache_oob();
> > -       memcg_accounted_kmem_cache();
> > -       kasan_stack_oob();
> > -       kasan_global_oob();
> > -       kasan_alloca_oob_left();
> > -       kasan_alloca_oob_right();
> > -       ksize_unpoisons_memory();
> >         copy_user_test();
> > -       kmem_cache_double_free();
> > -       kmem_cache_invalid_free();
> > -       kasan_memchr();
> > -       kasan_memcmp();
> > -       kasan_strings();
> > -       kasan_bitops();
> > -       kmalloc_double_kzfree();
> > -       vmalloc_oob();
> >
> >         kasan_restore_multi_shot(multishot);
> >
> > @@ -827,4 +795,4 @@ static int __init kmalloc_tests_init(void)
> >  }
> >
> >  module_init(kmalloc_tests_init);
> > -MODULE_LICENSE("GPL");
> > +#endif /* IS_MODULE(CONFIG_TEST_KASAN) */
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >



-- 
Best,
Patricia Alfonso
