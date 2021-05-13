Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46A37F263
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 06:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhEMEpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 00:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEMEpu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 00:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B568761425;
        Thu, 13 May 2021 04:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620881081;
        bh=0eRCsa825ZZVZO1LVEosg5gh2uAc3o9YDAtZzjcpTKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g82xDo6hWnPw/vISDdZ/uV5dxS47t99wzcTl2GWVxJvToXBPeBvpz0ShQzBVBG5ND
         bh0BOdcplDTX/CDAvtipQJ2fHDQWWLbtt8l7WJ92nrCDY6dGjfrUXTyH4VHUH3uwr8
         efXjZ4SgAaznw8o7IG5u3CXr2HxNJbQMwHP0Nmj8=
Date:   Wed, 12 May 2021 21:44:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     glittao@gmail.com
Cc:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com
Subject: Re: [PATCH v5 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
Message-Id: <20210512214440.e2cb47f751137db9802da62e@linux-foundation.org>
In-Reply-To: <20210511150734.3492-2-glittao@gmail.com>
References: <20210511150734.3492-1-glittao@gmail.com>
        <20210511150734.3492-2-glittao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 11 May 2021 17:07:33 +0200 glittao@gmail.com wrote:

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
> Tests next_pointer, first_word and clobber_50th_byte do not run
> with KASAN option on. Because the test deliberately modifies non-allocated
> objects.
> 
> Use kunit_resource to count errors in cache and silence bug reports.
> Count error whenever slab_bug() or slab_fix() is called or when
> the count of pages is wrong.
> 
> ...
>
>  lib/slub_kunit.c  | 155 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h         |   1 +
>  mm/slub.c         |  46 +++++++++++++-
>  5 files changed, 212 insertions(+), 3 deletions(-)
>  create mode 100644 lib/slub_kunit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..7723f58a9394 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2429,6 +2429,18 @@ config BITS_TEST
> 
>  	  If unsure, say N.
> 
> +config SLUB_KUNIT_TEST
> +	tristate "KUnit test for SLUB cache error detection" if !KUNIT_ALL_TESTS

This means it can be compiled as a kernel module.  Did you runtime test the
code as a module?

ERROR: modpost: "kasan_enable_current" [lib/slub_kunit.ko] undefined!
ERROR: modpost: "kasan_disable_current" [lib/slub_kunit.ko] undefined!

--- a/mm/kasan/common.c~a
+++ a/mm/kasan/common.c
@@ -51,11 +51,14 @@ void kasan_enable_current(void)
 {
 	current->kasan_depth++;
 }
+EXPORT_SYMBOL(kasan_enable_current);
 
 void kasan_disable_current(void)
 {
 	current->kasan_depth--;
 }
+EXPORT_SYMBOL(kasan_disable_current);
+
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 void __kasan_unpoison_range(const void *address, size_t size)
_

