Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0035E0AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 15:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDMNyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbhDMNyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 09:54:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9BDC061756
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 06:54:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x77so7671813oix.8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShLbnr1P8rkomLYtDMJuS+GJV1J/N9tQY9gZZ3VLsqM=;
        b=momaoOWW1dQyvXZhp8dQKNr+tfrSuO3BzjtKbBNiLtCrmH7CIXWRXpBehLKG+mWy0x
         DfNhg5CGtE89yl60qDwj91BM8H19taA3n7pUtqykfsMJdDLAoRlSlIhWdFKalpNLFSYB
         CzH9kgmlZ+1bhTxdu1qvBKbSLr3Vn7ZBlcnRo6YUCC7gji+uGOjypQ8mjTBVPv63HQfk
         jqiROXEYrGFVA7cGJ82dUbxGM2rjdt7nl3isxIeP9/HdF3nFu21aLRYsOv1vn9qh8kaO
         KKas+ezzUo3mvlhftkMKc0TYB5kzRuQMzw3JGm17jrDxXigG6Pv2Y0RbuHleZII1KaTd
         TDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShLbnr1P8rkomLYtDMJuS+GJV1J/N9tQY9gZZ3VLsqM=;
        b=IXkpBxFH8mQq2ZqXPRNiPNw3qgQWRUVy2HrzgzUgQmLe9FhZqjQ0xn4mMbv2sx+uiA
         mPxNxKozBWcbGad17GjBg6agb5DRqKieFLQem5K4M8W3MZv1mlQ6OMXwSkvhq+wMabsv
         kG30iZzvfNBdJaTo+Jlx2xvzT1QYJOPjD3lHzqPaj5ZqVGVclWM8Kk2fxCrxv46sD2sc
         oEdyVx1RZjbnIEZuuiOygg0jIQo2JUz8lu9GYDn0e2VDDdly3lXFpEf+SPCjIXT6wSdp
         3UDAC0Z/ZWM3XPqf3pDBK/79yz/zdV4U5hVTfbIMOO7j1dfeiB1aBo5k8/v0dZHRKuJa
         3axw==
X-Gm-Message-State: AOAM530E7br5Ms3eP4SA2gDifps007MDBFN2A2pjj46H1erbXJfQR+Jp
        A1/DQPmZeOo1YApXqq2YdNfcNMqjVIV7rUFgi4Wolw==
X-Google-Smtp-Source: ABdhPJz8sgcfKMPwDhaTisfENtsAh8kiIYb3fQ+WXEuQ7QEY2BXwGlzMye8wDd+3KT2NkWL0fQ3R+m0LXP1N1CWfNl8=
X-Received: by 2002:aca:408a:: with SMTP id n132mr114803oia.70.1618322058975;
 Tue, 13 Apr 2021 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210413100747.4921-1-glittao@gmail.com> <20210413100747.4921-2-glittao@gmail.com>
In-Reply-To: <20210413100747.4921-2-glittao@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 13 Apr 2021 15:54:06 +0200
Message-ID: <CANpmjNOOWuiR6Lb1igX+5Lp=PwcEE7Gx5co5KeGCnGz2WxbjNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     glittao@gmail.com
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 13 Apr 2021 at 12:07, <glittao@gmail.com> wrote:
> From: Oliver Glitta <glittao@gmail.com>
>
> SLUB has resiliency_test() function which is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it. KUnit should be a proper replacement for it.
>
> Try changing byte in redzone after allocation and changing
> pointer to next free node, first byte, 50th byte and redzone
> byte. Check if validation finds errors.
>
> There are several differences from the original resiliency test:
> Tests create own caches with known state instead of corrupting
> shared kmalloc caches.
>
> The corruption of freepointer uses correct offset, the original
> resiliency test got broken with freepointer changes.
>
> Scratch changing random byte test, because it does not have
> meaning in this form where we need deterministic results.
>
> Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> Because the test deliberatly modifies non-allocated objects, it depends on
> !KASAN which would have otherwise prevented that.

Hmm, did the test fail with KASAN? Is it possible to skip the tests
and still run a subset of tests with KASAN? It'd be nice if we could
run some of these tests with KASAN as well.

> Use kunit_resource to count errors in cache and silence bug reports.
> Count error whenever slab_bug() or slab_fix() is called or when
> the count of pages is wrong.
>
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks, this all looks good to me. But perhaps do test what works with
KASAN, to see if you need the !KASAN constraint for all cases.

> ---
> Changes since v3
>
> Use kunit_resource to silence bug reports and count errors suggested by
> Marco Elver.
> Make the test depends on !KASAN thanks to report from the kernel test robot.
>
> Changes since v2
>
> Use bit operation & instead of logical && as reported by kernel test
> robot and Dan Carpenter
>
> Changes since v1
>
> Conversion from kselftest to KUnit test suggested by Marco Elver.
> Error silencing.
> Error counting improvements.
>  lib/Kconfig.debug |  12 ++++
>  lib/Makefile      |   1 +
>  lib/slub_kunit.c  | 150 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h         |   1 +
>  mm/slub.c         |  50 ++++++++++++++--
>  5 files changed, 209 insertions(+), 5 deletions(-)
>  create mode 100644 lib/slub_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..9b8a0d754278 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2371,6 +2371,18 @@ config BITS_TEST
>
>           If unsure, say N.
>
> +config SLUB_KUNIT_TEST
> +       tristate "KUnit test for SLUB cache error detection" if !KUNIT_ALL_TESTS
> +       depends on SLUB_DEBUG && KUNIT && !KASAN
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds SLUB allocator unit test.
> +         Tests SLUB cache debugging functionality.
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index b5307d3eec1a..1e59c6714ed8 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -352,5 +352,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> +obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> new file mode 100644
> index 000000000000..cb9ae9f7e8a6
> --- /dev/null
> +++ b/lib/slub_kunit.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include "../mm/slab.h"
> +
> +static struct kunit_resource resource;
> +static int slab_errors;
> +
> +static void test_clobber_zone(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
> +                               SLAB_RED_ZONE, NULL);
> +       u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +       p[64] = 0x12;
> +
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +
> +       kmem_cache_free(s, p);
> +       kmem_cache_destroy(s);
> +}
> +
> +static void test_next_pointer(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
> +                               SLAB_POISON, NULL);
> +       u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +       unsigned long tmp;
> +       unsigned long *ptr_addr;
> +
> +       kmem_cache_free(s, p);
> +
> +       ptr_addr = (unsigned long *)(p + s->offset);
> +       tmp = *ptr_addr;
> +       p[s->offset] = 0x12;
> +
> +       /*
> +        * Expecting three errors.
> +        * One for the corrupted freechain and the other one for the wrong
> +        * count of objects in use. The third error is fixing broken cache.
> +        */
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 3, slab_errors);
> +
> +       /*
> +        * Try to repair corrupted freepointer.
> +        * Still expecting two errors. The first for the wrong count
> +        * of objects in use.
> +        * The second error is for fixing broken cache.
> +        */
> +       *ptr_addr = tmp;
> +       slab_errors = 0;
> +
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +
> +       /*
> +        * Previous validation repaired the count of objects in use.
> +        * Now expecting no error.
> +        */
> +       slab_errors = 0;
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 0, slab_errors);
> +
> +       kmem_cache_destroy(s);
> +}
> +
> +static void test_first_word(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
> +                               SLAB_POISON, NULL);
> +       u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +       kmem_cache_free(s, p);
> +       *p = 0x78;
> +
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +
> +       kmem_cache_destroy(s);
> +}
> +
> +static void test_clobber_50th_byte(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
> +                               SLAB_POISON, NULL);
> +       u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +       kmem_cache_free(s, p);
> +       p[50] = 0x9a;
> +
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +       kmem_cache_destroy(s);
> +}
> +
> +static void test_clobber_redzone_free(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
> +                               SLAB_RED_ZONE, NULL);
> +       u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +       kmem_cache_free(s, p);
> +       p[64] = 0xab;
> +
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +       kmem_cache_destroy(s);
> +}
> +
> +static int test_init(struct kunit *test)
> +{
> +       slab_errors = 0;
> +
> +       /* FIXME: remove when CONFIG_KASAN requirement is dropped. */
> +       current->kunit_test = test;

Note, the patch "kunit: support failure from dynamic analysis tools"
is already in -next. It's probably safe to leave this, and send a
follow-up patch later once that kunit patch is in mainline.

> +       kunit_add_named_resource(test, NULL, NULL, &resource,
> +                                       "slab_errors", &slab_errors);
> +       return 0;
> +}
> +
> +static void test_exit(struct kunit *test)
> +{
> +       /* FIXME: remove when CONFIG_KASAN requirement is dropped. */
> +       current->kunit_test = NULL;
> +}
> +
> +static struct kunit_case test_cases[] = {
> +       KUNIT_CASE(test_clobber_zone),
> +       KUNIT_CASE(test_next_pointer),
> +       KUNIT_CASE(test_first_word),
> +       KUNIT_CASE(test_clobber_50th_byte),
> +       KUNIT_CASE(test_clobber_redzone_free),
> +       {}
> +};
> +
> +static struct kunit_suite test_suite = {
> +       .name = "slub_test",
> +       .init = test_init,
> +       .exit = test_exit,
> +       .test_cases = test_cases,
> +};
> +kunit_test_suite(test_suite);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f58f68..95cf42eb8396 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -215,6 +215,7 @@ DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
>  DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  extern void print_tracking(struct kmem_cache *s, void *object);
> +long validate_slab_cache(struct kmem_cache *s);
>  #else
>  static inline void print_tracking(struct kmem_cache *s, void *object)
>  {
> diff --git a/mm/slub.c b/mm/slub.c
> index 3021ce9bf1b3..d7df8841d90a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -35,6 +35,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
> +#include <kunit/test.h>
>
>  #include <trace/events/kmem.h>
>
> @@ -447,6 +448,26 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>  static DEFINE_SPINLOCK(object_map_lock);
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +static bool slab_add_kunit_errors(void)
> +{
> +       struct kunit_resource *resource;
> +
> +       if (likely(!current->kunit_test))
> +               return false;
> +
> +       resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
> +       if (!resource)
> +               return false;
> +
> +       (*(int *)resource->data)++;
> +       kunit_put_resource(resource);
> +       return true;
> +}
> +#else
> +static inline bool slab_add_kunit_errors(void) { return false; }
> +#endif
> +
>  /*
>   * Determine a map of object in use on a page.
>   *
> @@ -676,6 +697,9 @@ static void slab_fix(struct kmem_cache *s, char *fmt, ...)
>         struct va_format vaf;
>         va_list args;
>
> +       if (slab_add_kunit_errors())
> +               return;
> +
>         va_start(args, fmt);
>         vaf.fmt = fmt;
>         vaf.va = &args;
> @@ -739,6 +763,9 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  void object_err(struct kmem_cache *s, struct page *page,
>                         u8 *object, char *reason)
>  {
> +       if (slab_add_kunit_errors())
> +               return;
> +
>         slab_bug(s, "%s", reason);
>         print_trailer(s, page, object);
>  }
> @@ -749,6 +776,9 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
>         va_list args;
>         char buf[100];
>
> +       if (slab_add_kunit_errors())
> +               return;
> +
>         va_start(args, fmt);
>         vsnprintf(buf, sizeof(buf), fmt, args);
>         va_end(args);
> @@ -798,12 +828,16 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>         while (end > fault && end[-1] == value)
>                 end--;
>
> +       if (slab_add_kunit_errors())
> +               goto skip_bug_print;
> +
>         slab_bug(s, "%s overwritten", what);
>         pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> -                                       fault, end - 1, fault - addr,
> -                                       fault[0], value);
> +                               fault, end - 1, fault - addr,
> +                               fault[0], value);
>         print_trailer(s, page, object);
>
> +skip_bug_print:
>         restore_bytes(s, what, value, fault, end);
>         return 0;
>  }
> @@ -4650,9 +4684,11 @@ static int validate_slab_node(struct kmem_cache *s,
>                 validate_slab(s, page);
>                 count++;
>         }
> -       if (count != n->nr_partial)
> +       if (count != n->nr_partial) {
>                 pr_err("SLUB %s: %ld partial slabs counted but counter=%ld\n",
>                        s->name, count, n->nr_partial);
> +               slab_add_kunit_errors();
> +       }
>
>         if (!(s->flags & SLAB_STORE_USER))
>                 goto out;
> @@ -4661,16 +4697,18 @@ static int validate_slab_node(struct kmem_cache *s,
>                 validate_slab(s, page);
>                 count++;
>         }
> -       if (count != atomic_long_read(&n->nr_slabs))
> +       if (count != atomic_long_read(&n->nr_slabs)) {
>                 pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
>                        s->name, count, atomic_long_read(&n->nr_slabs));
> +               slab_add_kunit_errors();
> +       }
>
>  out:
>         spin_unlock_irqrestore(&n->list_lock, flags);
>         return count;
>  }
>
> -static long validate_slab_cache(struct kmem_cache *s)
> +long validate_slab_cache(struct kmem_cache *s)
>  {
>         int node;
>         unsigned long count = 0;
> @@ -4682,6 +4720,8 @@ static long validate_slab_cache(struct kmem_cache *s)
>
>         return count;
>  }
> +EXPORT_SYMBOL(validate_slab_cache);
> +
>  /*
>   * Generate lists of code addresses where slabcache objects are allocated
>   * and freed.
> --
> 2.31.1.272.g89b43f80a5
>
