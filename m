Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADE337F4DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEMJdj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhEMJdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 05:33:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33317C061574;
        Thu, 13 May 2021 02:32:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x188so21180678pfd.7;
        Thu, 13 May 2021 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y6ILpkaBg+FtcNPZgTxL2hRTdEI8pBD+QYAkn5BUeac=;
        b=j4V3cxsxyZdsyKcDBQwiz2UgNPTMA4LjAx6DagnigMcMd5XYZbAkvfqhL0n7vL/WtC
         9mQtFIa4wzBw1mNJlkAjy2mYOQRf1WNoaq6K7Xm6TOhTsoZiWUgh03Z/B6QfbpXAqnOd
         LDdYVBtPN24TvpDzJrkxjcOEL9kXzwpDB1PT9WPzlN8Fe2b+qg4IS/G293rmq2nHakyP
         aq73BZZv2eC6tjnGfa+Q2yCL3TrL2O3WmHa59WJplC3e4nxtvF0Ncn8XueFHVJf1NL/M
         TD9GfOK8wghPCNg/kw5yJ4ML+Fys3eSwRfpgLlhibzsNpWXTdQIfPXXH3hUw8b6XXlte
         bX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y6ILpkaBg+FtcNPZgTxL2hRTdEI8pBD+QYAkn5BUeac=;
        b=QBrrPx24etVISv8vYb4CQ7zDCPFrrW4DUe3/TybtrbPMNfcAVSMAS8Fa6sWP+Jm/fv
         1PSbRGRnhFrJ65xJrlB2atWUXwKijh1zDQJ72UFNo/SuEhws45SrRwspeCjjd7T+zoaw
         bdwX4VERDh1aiLYbHVou4xyN4x8kjS2ewXEAvwmn7KdhEj666lmWfrvQkF76FBZlmZhv
         +AKKiFsYUnSBxPGaP3aWRZaI4eYpE5pUjR5BxkJbjA1MuFOJSBb6Eevy2AhDhrI40l2G
         Q/3cNgBUbya61HJtpAN0yVWJXdCiumDs+PtheIIER0NREHg8ijwsUXiUG0E2k6HrqLkn
         vg3g==
X-Gm-Message-State: AOAM531BK0jhIjM7N95Y/spQ0rB5VtgNDP60/71BP8VtnR2VBhxQetBp
        WiYuQ7ZcrbvFyBXgprLr8olHZyBn0OMtVVAFEwc=
X-Google-Smtp-Source: ABdhPJydklIlaECNvDCdgzGIU72z7efku8U8OJQZ8YBvFBBffkcfAdv7j61GLbK/lZB4w9qFZ4UxoAMs5Z0ysUIr+0E=
X-Received: by 2002:a62:8389:0:b029:27d:28f4:d583 with SMTP id
 h131-20020a6283890000b029027d28f4d583mr40154368pfe.33.1620898348683; Thu, 13
 May 2021 02:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210511150734.3492-1-glittao@gmail.com> <20210511150734.3492-2-glittao@gmail.com>
 <20210512214440.e2cb47f751137db9802da62e@linux-foundation.org>
In-Reply-To: <20210512214440.e2cb47f751137db9802da62e@linux-foundation.org>
From:   Oliver Glitta <glittao@gmail.com>
Date:   Thu, 13 May 2021 11:32:17 +0200
Message-ID: <CAD=R=qpH+GHcWzgZtd42uFRr8VgeQ=YMUPJnwjQadEQ_azdo0g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

=C5=A1t 13. 5. 2021 o 6:44 Andrew Morton <akpm@linux-foundation.org> nap=C3=
=ADsal(a):
>
> On Tue, 11 May 2021 17:07:33 +0200 glittao@gmail.com wrote:
>
> > From: Oliver Glitta <glittao@gmail.com>
> >
> > SLUB has resiliency_test() function which is hidden behind #ifdef
> > SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> > runs it. KUnit should be a proper replacement for it.
> >
> > Try changing byte in redzone after allocation and changing
> > pointer to next free node, first byte, 50th byte and redzone
> > byte. Check if validation finds errors.
> >
> > There are several differences from the original resiliency test:
> > Tests create own caches with known state instead of corrupting
> > shared kmalloc caches.
> >
> > The corruption of freepointer uses correct offset, the original
> > resiliency test got broken with freepointer changes.
> >
> > Scratch changing random byte test, because it does not have
> > meaning in this form where we need deterministic results.
> >
> > Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> > Tests next_pointer, first_word and clobber_50th_byte do not run
> > with KASAN option on. Because the test deliberately modifies non-alloca=
ted
> > objects.
> >
> > Use kunit_resource to count errors in cache and silence bug reports.
> > Count error whenever slab_bug() or slab_fix() is called or when
> > the count of pages is wrong.
> >
> > ...
> >
> >  lib/slub_kunit.c  | 155 ++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slab.h         |   1 +
> >  mm/slub.c         |  46 +++++++++++++-
> >  5 files changed, 212 insertions(+), 3 deletions(-)
> >  create mode 100644 lib/slub_kunit.c
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 678c13967580..7723f58a9394 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2429,6 +2429,18 @@ config BITS_TEST
> >
> >         If unsure, say N.
> >
> > +config SLUB_KUNIT_TEST
> > +     tristate "KUnit test for SLUB cache error detection" if !KUNIT_AL=
L_TESTS
>
> This means it can be compiled as a kernel module.  Did you runtime test t=
he
> code as a module?
>
We tested this as a module in the previous version, but I forgot to
try it with this new one. So we didn't find this error.
Thank you for your fix.

> ERROR: modpost: "kasan_enable_current" [lib/slub_kunit.ko] undefined!
> ERROR: modpost: "kasan_disable_current" [lib/slub_kunit.ko] undefined!
>
> --- a/mm/kasan/common.c~a
> +++ a/mm/kasan/common.c
> @@ -51,11 +51,14 @@ void kasan_enable_current(void)
>  {
>         current->kasan_depth++;
>  }
> +EXPORT_SYMBOL(kasan_enable_current);
>
>  void kasan_disable_current(void)
>  {
>         current->kasan_depth--;
>  }
> +EXPORT_SYMBOL(kasan_disable_current);
> +
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  void __kasan_unpoison_range(const void *address, size_t size)
> _
>
