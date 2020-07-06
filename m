Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C829216104
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGFVjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgGFVjN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:39:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D086C061755
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 14:39:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so36338273qkc.6
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ohHz7XaAelJ+IeoL9u3FKB/eOYzdH+WTzRsEc/PT9Xg=;
        b=C3SIplasJuQjuRjzdGfKR2JWtxgDzAV+8MUmXy6eX0YlrDe9aIFsCmSzOEfADxzvju
         OHGSZgP5ArdqRQE0vUrpDWvZoAt8I/2R7aA79Qz6QxxdXQQlynY+3Awqe6+G5Z+YYo0o
         PgVnrZQPkHyrVBEewA98bQ1tnEeIq8APZXbbyplMMPBnDuM2rfouMZtl3bGd3eFtry1a
         qHBraOzlLEr7SM6aMNDRpxSatzPOX2kvjQqutwuq8BFDEnXRbJZDNxRZZ8pGzPDdw8uT
         IajYlN24oNw6SksTZ1V+cs7rLSU9OyWOjeNNC3KxWPfzmnGLh2tqU5c0HWm83wg/C2+P
         J2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohHz7XaAelJ+IeoL9u3FKB/eOYzdH+WTzRsEc/PT9Xg=;
        b=HJ2XKLBqtziLPGr33POrkwTRKX1cUgrOHGHTAiAp9A615mfRk2hudRMjdKmkJ380bh
         Fi/GKkYelQFsJ5th0Aogoyn2qd0ea9TmGz+Mkp6jqLBBYVJOLuL00dc313T7+2K8Gmnc
         FIvyb3s0EIq2ZM3hqxxKlxpyDUYYdgqNXVHmZDWf1o8wJbz93xPOY49YO5albV+q+q/Z
         fAGzMJ8G5owYlS6ps3qp7xwEkFDi39nlOiqBW3BWymb9mNYpx/Fms/jf4jimDzVUiC5s
         hpNTHUXBhLuJaEC1vUZ1iGPzFOrF7Tmq7DKEW32FCNiEkL0lh4FlRCnMeKHrMmjq4am6
         x6kA==
X-Gm-Message-State: AOAM533mJNWI4kXkb/ZFn/uKsD4aMt7Y+9NxQwE91nxNiwybceSawmEy
        uCqD/F9WQv7i3f5hAmxWp3oPFw==
X-Google-Smtp-Source: ABdhPJw0towMog1A8OUi+/9dbB3bMfiSlt4WhWQR7PATWfrBc4TiTENuCfKXehhBQWhthkMj14ut2A==
X-Received: by 2002:a05:620a:10af:: with SMTP id h15mr50263600qkk.205.1594071552487;
        Mon, 06 Jul 2020 14:39:12 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f15sm19643678qka.120.2020.07.06.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:39:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 17:39:05 -0400
From:   Qian Cai <cai@lca.pw>
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org, 0x7f454c46@gmail.com,
        urielguajardo@google.com, krzk@kernel.org, kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kunit: kmemleak integration
Message-ID: <20200706213905.GA1916@lca.pw>
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
 <20200706211309.3314644-3-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706211309.3314644-3-urielguajardojr@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 09:13:09PM +0000, Uriel Guajardo wrote:
> From: Uriel Guajardo <urielguajardo@google.com>
> 
> Integrate kmemleak into the KUnit testing framework.
> 
> Kmemleak will now fail the currently running KUnit test case if it finds
> any memory leaks.
> 
> The minimum object age for reporting is set to 0 msecs so that leaks are
> not ignored if the test case finishes too quickly.
> 
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>  include/linux/kmemleak.h | 11 +++++++++++
>  lib/Kconfig.debug        | 26 ++++++++++++++++++++++++++
>  lib/kunit/test.c         | 36 +++++++++++++++++++++++++++++++++++-
>  mm/kmemleak.c            | 27 +++++++++++++++++++++------
>  4 files changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
> index 34684b2026ab..0da427934462 100644
> --- a/include/linux/kmemleak.h
> +++ b/include/linux/kmemleak.h
> @@ -35,6 +35,10 @@ extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
>  extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
>  extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
>  
> +extern ssize_t kmemleak_write(struct file *file,
> +			      const char __user *user_buf,
> +			      size_t size, loff_t *ppos);
> +
>  static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
>  					    int min_count, slab_flags_t flags,
>  					    gfp_t gfp)
> @@ -120,6 +124,13 @@ static inline void kmemleak_ignore_phys(phys_addr_t phys)
>  {
>  }
>  
> +static inline ssize_t kmemleak_write(struct file *file,
> +				     const char __user *user_buf,
> +				     size_t size, loff_t *ppos)
> +{
> +	return -1;
> +}
> +
>  #endif	/* CONFIG_DEBUG_KMEMLEAK */
>  
>  #endif	/* __KMEMLEAK_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e7ec..e9c492cb3f4d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -602,6 +602,32 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
>  	  fully initialised, this memory pool acts as an emergency one
>  	  if slab allocations fail.
>  
> +config DEBUG_KMEMLEAK_MAX_TRACE
> +	int "Kmemleak stack trace length"
> +	depends on DEBUG_KMEMLEAK
> +	default 16
> +
> +config DEBUG_KMEMLEAK_MSECS_MIN_AGE
> +	int "Minimum object age before reporting in msecs"
> +	depends on DEBUG_KMEMLEAK
> +	default 0 if KUNIT
> +	default 5000
> +
> +config DEBUG_KMEMLEAK_SECS_FIRST_SCAN
> +	int "Delay before first scan in secs"
> +	depends on DEBUG_KMEMLEAK
> +	default 60
> +
> +config DEBUG_KMEMLEAK_SECS_SCAN_WAIT
> +	int "Delay before subsequent auto scans in secs"
> +	depends on DEBUG_KMEMLEAK
> +	default 600
> +
> +config DEBUG_KMEMLEAK_MAX_SCAN_SIZE
> +	int "Maximum size of scanned block"
> +	depends on DEBUG_KMEMLEAK
> +	default 4096
> +

Why do you make those configurable? I don't see anywhere you make use of
them except DEBUG_KMEMLEAK_MSECS_MIN_AGE?

Even then, how setting DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 not giving too
many false positives? Kmemleak simply does not work that instantly.

>  config DEBUG_KMEMLEAK_TEST
>  	tristate "Simple test for the kernel memory leak detector"
>  	depends on DEBUG_KMEMLEAK && m
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 8580ed831a8f..8d113a6a214b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,6 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> +#include <linux/kmemleak.h>
>  
>  #include "debugfs.h"
>  #include "string-stream.h"
> @@ -277,6 +278,27 @@ static void kunit_run_case_cleanup(struct kunit *test,
>  	kunit_case_internal_cleanup(test);
>  }
>  
> +/*
> + * Manually scans for memory leaks using the kmemleak tool.
> + *
> + * Any leaks that occurred since the previous scan will be
> + * reported and will cause the currently running test to fail.
> + */
> +static inline void kmemleak_scan(void)
> +{
> +	loff_t pos;
> +	kmemleak_write(NULL, "scan", 5, &pos);
> +}
> +
> +/*
> + * Turn off the background automatic scan that kmemleak performs upon starting
> + */
> +static inline void kmemleak_automatic_scan_off(void)
> +{
> +	loff_t pos;
> +	kmemleak_write(NULL, "scan=off", 9, &pos);
> +}
> +
>  struct kunit_try_catch_context {
>  	struct kunit *test;
>  	struct kunit_suite *suite;
> @@ -290,6 +312,12 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> +	/*
> +	 * Clear any reported memory leaks since last scan, so that only the
> +	 * leaks pertaining to the test case remain afterwards.
> +	 */
> +	kmemleak_scan();
> +
>  	current->kunit_test = test;
>  
>  	/*
> @@ -298,7 +326,12 @@ static void kunit_try_run_case(void *data)
>  	 * thread will resume control and handle any necessary clean up.
>  	 */
>  	kunit_run_case_internal(test, suite, test_case);
> -	/* This line may never be reached. */
> +
> +	/* These lines may never be reached. */
> +
> +	/* Report any detected memory leaks that occurred in the test case */
> +	kmemleak_scan();
> +
>  	kunit_run_case_cleanup(test, suite);
>  }
>  
> @@ -388,6 +421,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
>  int __kunit_test_suites_init(struct kunit_suite **suites)
>  {
>  	unsigned int i;
> +	kmemleak_automatic_scan_off();
>  
>  	for (i = 0; suites[i] != NULL; i++) {
>  		kunit_init_suite(suites[i]);
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index e362dc3d2028..ad046c77e00c 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -99,15 +99,26 @@
>  #include <linux/kasan.h>
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
> +#include <kunit/test.h>
>  
>  /*
>   * Kmemleak configuration and common defines.
>   */
> -#define MAX_TRACE		16	/* stack trace length */
> -#define MSECS_MIN_AGE		5000	/* minimum object age for reporting */
> -#define SECS_FIRST_SCAN		60	/* delay before the first scan */
> -#define SECS_SCAN_WAIT		600	/* subsequent auto scanning delay */
> -#define MAX_SCAN_SIZE		4096	/* maximum size of a scanned block */
> +
> +/* stack trace length */
> +#define MAX_TRACE		CONFIG_DEBUG_KMEMLEAK_MAX_TRACE
> +
> +/* minimum object age for reporting */
> +#define MSECS_MIN_AGE		CONFIG_DEBUG_KMEMLEAK_MSECS_MIN_AGE
> +
> +/* delay before the first scan */
> +#define SECS_FIRST_SCAN		CONFIG_DEBUG_KMEMLEAK_SECS_FIRST_SCAN
> +
> +/* subsequent auto scanning delay */
> +#define SECS_SCAN_WAIT		CONFIG_DEBUG_KMEMLEAK_SECS_SCAN_WAIT
> +
> +/* maximum size of a scanned lock */
> +#define MAX_SCAN_SIZE		CONFIG_DEBUG_KMEMLEAK_MAX_SCAN_SIZE
>  
>  #define BYTES_PER_POINTER	sizeof(void *)
>  
> @@ -1490,6 +1501,7 @@ static void kmemleak_scan(void)
>  	 * Check for new or unreferenced objects modified since the previous
>  	 * scan and color them gray until the next scan.
>  	 */
> +#if (!IS_ENABLED(CONFIG_KUNIT))
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(object, &object_list, object_list) {
>  		raw_spin_lock_irqsave(&object->lock, flags);
> @@ -1502,6 +1514,7 @@ static void kmemleak_scan(void)
>  		raw_spin_unlock_irqrestore(&object->lock, flags);
>  	}
>  	rcu_read_unlock();
> +#endif
>  
>  	/*
>  	 * Re-scan the gray list for modified unreferenced objects.
> @@ -1534,6 +1547,8 @@ static void kmemleak_scan(void)
>  	rcu_read_unlock();
>  
>  	if (new_leaks) {
> +		kunit_fail_current_test();
> +
>  		kmemleak_found_leaks = true;
>  
>  		pr_info("%d new suspected memory leaks (see /sys/kernel/debug/kmemleak)\n",
> @@ -1764,7 +1779,7 @@ static void __kmemleak_do_cleanup(void);
>   *		  if kmemleak has been disabled.
>   *   dump=...	- dump information about the object found at the given address
>   */
> -static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
> +ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
>  			      size_t size, loff_t *ppos)
>  {
>  	char buf[64];
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
> 
