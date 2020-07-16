Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19DB22287A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgGPQk6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgGPQk6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:40:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE2C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:40:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so5404268qto.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rEVktdT3E8GmpRO9z7GuMg2RGypgd6QLHPn36U0peL0=;
        b=PR2hvLReEYbJR9cIMtBEq1COW5wMj73sV5MOfIA3RUyPu+CjuaMLwbJ7PIyKwjDB6z
         qJMUbYvT7KtF8Cmi1WC8uluKTs5CaIa8OVxf/NbzUskdGuTPeZph87IL1bTRQgaNTn0E
         qxEyOlTV7By1HN/UVAw4Ih8sOm6XgcDOC3641pYsOhB3PfeprAlAGAx9suJMW/u4qabz
         ibpj75wh0HhDafVHHjZUmOYc6nPL3ZjpZn4ilBs230T93n8Gkg3RAtn5ANVWwumNMntD
         IqmNMSXx61N2lZATnsm2INDB3ZefWaXC2c7m5aiSiW9lhA65g0ffiplvYPBi424pEGfA
         rrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rEVktdT3E8GmpRO9z7GuMg2RGypgd6QLHPn36U0peL0=;
        b=K1sySdOCQ/zUxuN1BPuHv2NB8AOV+exjLfG2cvAWJXjJ48tTmSk4cgca/Pca3xn91Z
         Qoxt/xYnXWQpJLobcUFnJJAxGzhgyDB61rBq4hO4q1r1uMpQgadFc2YRg6CaxFrQEmF/
         iPhcEVKxNLHFAs2qK888LuSXwhuyZCrgRxaaOMNosTkWAvQcR03xs5dqDjVLucwuUJpK
         s2lz5UuqtWmQt3vBUSzNsC1TvReK267auJfoJasl9UgZb0j+oZb/rSPEU0H6Svv8farE
         MfX5FC1Gs2UKtmchoLfi3SlhQ/4fxGz9eb1CGhMu3WCZwx9fGwHqRXKWW9bWgdTAam6R
         P2/g==
X-Gm-Message-State: AOAM530SxGlM9BP00oKjVE1k7EkhmCRF2cmUDk6oLd00vtXN/YkhhB25
        bDLUWFWMzKDmIUrzNTpTXLbF9A==
X-Google-Smtp-Source: ABdhPJzu38nNsp52/BrVgV2d29aCDGqwkjFTb4zX58eEDB02VOHExz+CoQJxk433NYrDgu0s4OD2/A==
X-Received: by 2002:aed:32e5:: with SMTP id z92mr6036278qtd.282.1594917656830;
        Thu, 16 Jul 2020 09:40:56 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 19sm7518338qke.44.2020.07.16.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:40:54 -0700 (PDT)
Message-ID: <551419076ba8c6fbf9ca03786b660f6277dc665b.camel@massaru.org>
Subject: Re: [RFC 3/3] lib: Convert test_user_copy to KUnit test
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:40:51 -0300
In-Reply-To: <CAFd5g471kwX7pHRwksbjMoEyLPoNjwd1kjzvi19oNHn45-a_ew@mail.gmail.com>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <20200715031120.1002016-4-vitor@massaru.org>
         <CAFd5g471kwX7pHRwksbjMoEyLPoNjwd1kjzvi19oNHn45-a_ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 17:40 -0700, Brendan Higgins wrote:
> On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > This adds the conversion of the runtime tests of test_user_copy
> > fuctions,
> > from `lib/test_user_copy.c`to KUnit tests.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/Kconfig.debug                           |  17 ++
> >  lib/Makefile                                |   2 +-
> >  lib/{test_user_copy.c => user_copy_kunit.c} | 196 +++++++++-------
> > ----
> >  3 files changed, 102 insertions(+), 113 deletions(-)
> >  rename lib/{test_user_copy.c => user_copy_kunit.c} (55%)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 9ad9210d70a1..29558674c011 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2154,6 +2154,23 @@ config SYSCTL_KUNIT_TEST
> > 
> >           If unsure, say N.
> > 
> > +config USER_COPY_KUNIT
> > +       tristate "KUnit Test for user/kernel boundary protections"
> > +       depends on KUNIT
> > +       depends on m
> > +       help
> > +         This builds the "test_user_copy" module that runs sanity
> > checks
> > +         on the copy_to/from_user infrastructure, making sure
> > basic
> > +         user/kernel boundary testing is working. If it fails to
> > load,
> > +         a regression has been detected in the user/kernel memory
> > boundary
> > +         protections.
> > +
> > +          For more information on KUnit and unit tests in general
> > please refer
> > +         to the KUnit documentation in Documentation/dev-
> > tools/kunit/.
> > +
> > +         If unsure, say N.
> 
> Where do you delete the entry for CONFIG_TEST_USER_COPY? I don't see
> it here.

I didn't. Thanks I'll delete it.

> >  config LIST_KUNIT_TEST
> >         tristate "KUnit Test for Kernel Linked-list structures" if
> > !KUNIT_ALL_TESTS
> >         depends on KUNIT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index b1c42c10073b..8c145f85accc 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> >  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> >  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> >  obj-$(CONFIG_TEST_SORT) += test_sort.o
> > -obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> >  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
> >  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
> >  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
> > @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> >  # KUnit tests
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> > +obj-$(CONFIG_USER_COPY_KUNIT) += user_copy_kunit.o
> > diff --git a/lib/test_user_copy.c b/lib/user_copy_kunit.c
> > similarity index 55%
> > rename from lib/test_user_copy.c
> > rename to lib/user_copy_kunit.c
> > index 5ff04d8fe971..c15bb1e997d6 100644
> > --- a/lib/test_user_copy.c
> > +++ b/lib/user_copy_kunit.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/vmalloc.h>
> > +#include <kunit/test.h>
> > 
> >  /*
> >   * Several 32-bit architectures support 64-bit {get,put}_user()
> > calls.
> > @@ -31,26 +32,16 @@
> >  # define TEST_U64
> >  #endif
> > 
> > -#define test(condition, msg,
> > ...)                                      \
> > -({                                                                
> >      \
> > -       int cond =
> > (condition);                                         \
> > -       if
> > (cond)                                                       \
> > -               pr_warn("[%d] " msg "\n", __LINE__,
> > ##__VA_ARGS__);     \
> > -       cond;                                                      
> >      \
> > -})
> > -
> >  static bool is_zeroed(void *from, size_t size)
> >  {
> >         return memchr_inv(from, 0x0, size) == NULL;
> >  }
> > 
> > -static int test_check_nonzero_user(char *kmem, char __user *umem,
> > size_t size)
> > +static void test_check_nonzero_user(struct kunit *test, char
> > *kmem, char __user *umem, size_t size)
> >  {
> > -       int ret = 0;
> >         size_t start, end, i, zero_start, zero_end;
> > 
> > -       if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> > -               return -EINVAL;
> > +       KUNIT_EXPECT_FALSE_MSG(test, size < 2 * PAGE_SIZE, "buffer
> > too small");
> > 
> >         /*
> >          * We want to cross a page boundary to exercise the code
> > more
> > @@ -84,7 +75,7 @@ static int test_check_nonzero_user(char *kmem,
> > char __user *umem, size_t size)
> >         for (i = zero_end; i < size; i += 2)
> >                 kmem[i] = 0xff;
> > 
> > -       ret |= test(copy_to_user(umem, kmem, size),
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_to_user(umem, kmem,
> > size),
> >                     "legitimate copy_to_user failed");
> > 
> >         for (start = 0; start <= size; start++) {
> > @@ -93,35 +84,31 @@ static int test_check_nonzero_user(char *kmem,
> > char __user *umem, size_t size)
> >                         int retval = check_zeroed_user(umem +
> > start, len);
> >                         int expected = is_zeroed(kmem + start,
> > len);
> > 
> > -                       ret |= test(retval != expected,
> > -                                   "check_nonzero_user(=%d) !=
> > memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> > -                                   retval, expected, start, end);
> > +                       KUNIT_EXPECT_FALSE_MSG(test, retval !=
> > expected,
> > +                           "check_nonzero_user(=%d) !=
> > memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> > +                           retval, expected, start, end);
> >                 }
> >         }
> > -
> > -       return ret;
> >  }
> > 
> > -static int test_copy_struct_from_user(char *kmem, char __user
> > *umem,
> > +static void test_copy_struct_from_user(struct kunit *test, char
> > *kmem, char __user *umem,
> >                                       size_t size)
> >  {
> > -       int ret = 0;
> >         char *umem_src = NULL, *expected = NULL;
> >         size_t ksize, usize;
> > 
> >         umem_src = kmalloc(size, GFP_KERNEL);
> > -       ret = test(umem_src == NULL, "kmalloc failed");
> > -       if (ret)
> > -               goto out_free;
> > +       KUNIT_EXPECT_FALSE_MSG(test, umem_src == NULL, "kmalloc
> > failed");
> > 
> >         expected = kmalloc(size, GFP_KERNEL);
> > -       ret = test(expected == NULL, "kmalloc failed");
> > -       if (ret)
> > -               goto out_free;
> > +
> > +       if (expected == NULL)
> > +               kfree(umem_src);
> > +       KUNIT_EXPECT_FALSE_MSG(test, expected == NULL, "kmalloc
> > failed");
> > 
> >         /* Fill umem with a fixed byte pattern. */
> >         memset(umem_src, 0x3e, size);
> > -       ret |= test(copy_to_user(umem, umem_src, size),
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_to_user(umem, umem_src,
> > size),
> >                     "legitimate copy_to_user failed");
> > 
> >         /* Check basic case -- (usize == ksize). */
> > @@ -131,9 +118,9 @@ static int test_copy_struct_from_user(char
> > *kmem, char __user *umem,
> >         memcpy(expected, umem_src, ksize);
> > 
> >         memset(kmem, 0x0, size);
> > -       ret |= test(copy_struct_from_user(kmem, ksize, umem,
> > usize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_struct_from_user(kmem,
> > ksize, umem, usize),
> >                     "copy_struct_from_user(usize == ksize)
> > failed");
> > -       ret |= test(memcmp(kmem, expected, ksize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, memcmp(kmem, expected, ksize),
> >                     "copy_struct_from_user(usize == ksize) gives
> > unexpected copy");
> > 
> >         /* Old userspace case -- (usize < ksize). */
> > @@ -144,9 +131,9 @@ static int test_copy_struct_from_user(char
> > *kmem, char __user *umem,
> >         memset(expected + usize, 0x0, ksize - usize);
> > 
> >         memset(kmem, 0x0, size);
> > -       ret |= test(copy_struct_from_user(kmem, ksize, umem,
> > usize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_struct_from_user(kmem,
> > ksize, umem, usize),
> >                     "copy_struct_from_user(usize < ksize) failed");
> > -       ret |= test(memcmp(kmem, expected, ksize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, memcmp(kmem, expected, ksize),
> >                     "copy_struct_from_user(usize < ksize) gives
> > unexpected copy");
> > 
> >         /* New userspace (-E2BIG) case -- (usize > ksize). */
> > @@ -154,7 +141,7 @@ static int test_copy_struct_from_user(char
> > *kmem, char __user *umem,
> >         usize = size;
> > 
> >         memset(kmem, 0x0, size);
> > -       ret |= test(copy_struct_from_user(kmem, ksize, umem, usize)
> > != -E2BIG,
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_struct_from_user(kmem,
> > ksize, umem, usize) != -E2BIG,
> >                     "copy_struct_from_user(usize > ksize) didn't
> > give E2BIG");
> > 
> >         /* New userspace (success) case -- (usize > ksize). */
> > @@ -162,24 +149,18 @@ static int test_copy_struct_from_user(char
> > *kmem, char __user *umem,
> >         usize = size;
> > 
> >         memcpy(expected, umem_src, ksize);
> > -       ret |= test(clear_user(umem + ksize, usize - ksize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, clear_user(umem + ksize, usize
> > - ksize),
> >                     "legitimate clear_user failed");
> > 
> >         memset(kmem, 0x0, size);
> > -       ret |= test(copy_struct_from_user(kmem, ksize, umem,
> > usize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_struct_from_user(kmem,
> > ksize, umem, usize),
> >                     "copy_struct_from_user(usize > ksize) failed");
> > -       ret |= test(memcmp(kmem, expected, ksize),
> > +       KUNIT_EXPECT_FALSE_MSG(test, memcmp(kmem, expected, ksize),
> >                     "copy_struct_from_user(usize > ksize) gives
> > unexpected copy");
> > -
> > -out_free:
> > -       kfree(expected);
> > -       kfree(umem_src);
> > -       return ret;
> >  }
> > 
> > -static int __init test_user_copy_init(void)
> > +static void user_copy_test(struct kunit *test)
> >  {
> > -       int ret = 0;
> >         char *kmem;
> >         char __user *usermem;
> >         char *bad_usermem;
> > @@ -192,16 +173,14 @@ static int __init test_user_copy_init(void)
> >  #endif
> > 
> >         kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
> > -       if (!kmem)
> > -               return -ENOMEM;
> > +       KUNIT_EXPECT_FALSE_MSG(test, kmem == NULL, "kmalloc
> > failed");
> > 
> >         user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
> >                             PROT_READ | PROT_WRITE | PROT_EXEC,
> >                             MAP_ANONYMOUS | MAP_PRIVATE, 0);
> >         if (user_addr >= (unsigned long)(TASK_SIZE)) {
> > -               pr_warn("Failed to allocate user memory\n");
> >                 kfree(kmem);
> > -               return -ENOMEM;
> > +               KUNIT_FAIL(test, "Failed to allocate user memory");
> >         }
> > 
> >         usermem = (char __user *)user_addr;
> > @@ -211,29 +190,29 @@ static int __init test_user_copy_init(void)
> >          * Legitimate usage: none of these copies should fail.
> >          */
> >         memset(kmem, 0x3a, PAGE_SIZE * 2);
> > -       ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
> > -                   "legitimate copy_to_user failed");
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_to_user(usermem, kmem,
> > PAGE_SIZE), "legitimate copy_to_user failed");
> > +
> >         memset(kmem, 0x0, PAGE_SIZE);
> > -       ret |= test(copy_from_user(kmem, usermem, PAGE_SIZE),
> > -                   "legitimate copy_from_user failed");
> > -       ret |= test(memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
> > -                   "legitimate usercopy failed to copy data");
> > -
> > -#define test_legit(size,
> > check)                                                  \
> > -       do
> > {                                                              \
> > -               val_##size =
> > check;                                       \
> > -               ret |= test(put_user(val_##size, (size __user
> > *)usermem), \
> > -                   "legitimate put_user (" #size ")
> > failed");            \
> > -               val_##size =
> > 0;                                           \
> > -               ret |= test(get_user(val_##size, (size __user
> > *)usermem), \
> > -                   "legitimate get_user (" #size ")
> > failed");            \
> > -               ret |= test(val_##size !=
> > check,                          \
> > -                   "legitimate get_user (" #size ") failed to do
> > copy"); \
> > -               if (val_##size != check)
> > {                                \
> > -                       pr_info("0x%llx !=
> > 0x%llx\n",                     \
> > -                               (unsigned long
> > long)val_##size,           \
> > -                               (unsigned long
> > long)check);               \
> > -               }                                                  
> >        \
> > +       KUNIT_EXPECT_FALSE_MSG(test, copy_from_user(kmem, usermem,
> > PAGE_SIZE),
> > +                              "legitimate copy_from_user failed");
> > +       KUNIT_EXPECT_FALSE_MSG(test, memcmp(kmem, kmem + PAGE_SIZE,
> > PAGE_SIZE),
> > +                              "legitimate usercopy failed to copy
> > data");
> > +
> > +#define test_legit(size,
> > check)                                                             
> >            \
> > +       do
> > {                                                                  
> >                   \
> > +               val_##size =
> > check;                                                             
> > \
> > +               KUNIT_EXPECT_FALSE_MSG(test, put_user(val_##size,
> > (size __user *)usermem),      \
> > +                               "legitimate put_user (" #size ")
> > failed");                      \
> > +               val_##size =
> > 0;                                                                 
> > \
> > +               KUNIT_EXPECT_FALSE_MSG(test, get_user(val_##size,
> > (size __user *)usermem),      \
> > +                               "legitimate get_user (" #size ")
> > failed");                      \
> > +               KUNIT_EXPECT_FALSE_MSG(test, val_##size !=
> > check,                               \
> > +                               "legitimate get_user (" #size ")
> > failed to do copy");           \
> > +               if (val_##size != check)
> > {                                                      \
> > +                       kunit_info(test, "0x%llx !=
> > 0x%llx\n",                                  \
> > +                               (unsigned long
> > long)val_##size,                                 \
> > +                               (unsigned long
> > long)check);                                     \
> > +               }                                                  
> >                              \
> >         } while (0)
> > 
> >         test_legit(u8,  0x5a);
> > @@ -245,9 +224,9 @@ static int __init test_user_copy_init(void)
> >  #undef test_legit
> > 
> >         /* Test usage of check_nonzero_user(). */
> > -       ret |= test_check_nonzero_user(kmem, usermem, 2 *
> > PAGE_SIZE);
> > +       test_check_nonzero_user(test, kmem, usermem, 2 *
> > PAGE_SIZE);
> >         /* Test usage of copy_struct_from_user(). */
> > -       ret |= test_copy_struct_from_user(kmem, usermem, 2 *
> > PAGE_SIZE);
> > +       test_copy_struct_from_user(test, kmem, usermem, 2 *
> > PAGE_SIZE);
> > 
> >         /*
> >          * Invalid usage: none of these copies should succeed.
> > @@ -258,13 +237,13 @@ static int __init test_user_copy_init(void)
> >         memset(kmem + PAGE_SIZE, 0, PAGE_SIZE);
> > 
> >         /* Reject kernel-to-kernel copies through copy_from_user().
> > */
> > -       ret |= test(!copy_from_user(kmem, (char __user *)(kmem +
> > PAGE_SIZE),
> > -                                   PAGE_SIZE),
> > -                   "illegal all-kernel copy_from_user passed");
> > +       KUNIT_EXPECT_FALSE_MSG(test, !copy_from_user(kmem, (char
> > __user *)(kmem + PAGE_SIZE),
> > +                                                PAGE_SIZE),
> > +                               "illegal all-kernel copy_from_user
> > passed");
> > 
> >         /* Destination half of buffer should have been zeroed. */
> > -       ret |= test(memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE),
> > -                   "zeroing failure for illegal all-kernel
> > copy_from_user");
> > +       KUNIT_EXPECT_FALSE_MSG(test, memcmp(kmem + PAGE_SIZE, kmem,
> > PAGE_SIZE),
> > +                       "zeroing failure for illegal all-kernel
> > copy_from_user");
> > 
> >  #if 0
> >         /*
> > @@ -273,30 +252,28 @@ static int __init test_user_copy_init(void)
> >          * to be tested in LKDTM instead, since this test module
> > does not
> >          * expect to explode.
> >          */
> > -       ret |= test(!copy_from_user(bad_usermem, (char __user
> > *)kmem,
> > -                                   PAGE_SIZE),
> > -                   "illegal reversed copy_from_user passed");
> > +       KUNIT_EXPECT_FALSE_MSG(test, !copy_from_user(bad_usermem,
> > (char __user *)kmem,
> > +                                                    PAGE_SIZE),
> > +                               "illegal reversed copy_from_user
> > passed");
> >  #endif
> > -       ret |= test(!copy_to_user((char __user *)kmem, kmem +
> > PAGE_SIZE,
> > -                                 PAGE_SIZE),
> > -                   "illegal all-kernel copy_to_user passed");
> > -       ret |= test(!copy_to_user((char __user *)kmem, bad_usermem,
> > -                                 PAGE_SIZE),
> > -                   "illegal reversed copy_to_user passed");
> > -
> > -#define test_illegal(size,
> > check)                                          \
> > -       do
> > {                                                                \
> > -               val_##size =
> > (check);                                       \
> > -               ret |= test(!get_user(val_##size, (size __user
> > *)kmem),     \
> > -                   "illegal get_user (" #size ")
> > passed");                 \
> > -               ret |= test(val_##size !=
> > (size)0,                          \
> > -                   "zeroing failure for illegal get_user (" #size
> > ")");    \
> > -               if (val_##size != (size)0)
> > {                                \
> > -                       pr_info("0x%llx !=
> > 0\n",                            \
> > -                               (unsigned long
> > long)val_##size);            \
> > -               }                                                  
> >          \
> > -               ret |= test(!put_user(val_##size, (size __user
> > *)kmem),     \
> > -                   "illegal put_user (" #size ")
> > passed");                 \
> > +       KUNIT_EXPECT_FALSE_MSG(test, !copy_to_user((char __user
> > *)kmem, kmem + PAGE_SIZE, PAGE_SIZE),
> > +                       "illegal all-kernel copy_to_user passed");
> > +       KUNIT_EXPECT_FALSE_MSG(test, !copy_to_user((char __user
> > *)kmem, bad_usermem, PAGE_SIZE),
> > +                       "illegal reversed copy_to_user passed");
> > +
> > +#define test_illegal(size,
> > check)                                                             
> >  \
> > +       do
> > {                                                                  
> >                   \
> > +               val_##size =
> > (check);                                                           
> > \
> > +               KUNIT_EXPECT_FALSE_MSG(test, !get_user(val_##size,
> > (size __user *)kmem),        \
> > +                               "illegal get_user (" #size ")
> > passed");                         \
> > +               KUNIT_EXPECT_FALSE_MSG(test, val_##size !=
> > (size)0,                             \
> > +                               "zeroing failure for illegal
> > get_user (" #size ")");            \
> > +               if (val_##size != (size)0)
> > {                                                    \
> > +                       kunit_info(test, "0x%llx !=
> > 0\n",                                       \
> > +                                       (unsigned long
> > long)val_##size);                        \
> > +               }                                                  
> >                              \
> > +               KUNIT_EXPECT_FALSE_MSG(test, !put_user(val_##size,
> > (size __user *)kmem),        \
> > +                               "illegal put_user (" #size ")
> > passed");                         \
> >         } while (0)
> > 
> >         test_illegal(u8,  0x5a);
> > @@ -309,23 +286,18 @@ static int __init test_user_copy_init(void)
> > 
> >         vm_munmap(user_addr, PAGE_SIZE * 2);
> >         kfree(kmem);
> > -
> > -       if (ret == 0) {
> > -               pr_info("tests passed.\n");
> > -               return 0;
> > -       }
> > -
> > -       return -EINVAL;
> >  }
> > 
> > -module_init(test_user_copy_init);
> > -
> > -static void __exit test_user_copy_exit(void)
> > -{
> > -       pr_info("unloaded.\n");
> > -}
> > +static struct kunit_case user_copy_test_cases[] = {
> > +       KUNIT_CASE(user_copy_test),
> > +       {}
> > +};
> > 
> > -module_exit(test_user_copy_exit);
> > +static struct kunit_suite user_copy_test_suite = {
> > +       .name = "user_copy",
> > +       .test_cases = user_copy_test_cases,
> > +};
> > 
> > +kunit_test_suites(&user_copy_test_suite);
> >  MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
> >  MODULE_LICENSE("GPL");
> > --
> > 2.26.2
> > 

