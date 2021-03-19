Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FE341B4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 12:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCSLUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSLUL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 07:20:11 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6FC06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 04:20:10 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so2204161oot.4
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=563BAybzVyHEsgNkhjo3Ec3csusCS7gRQaGdAB7Gmag=;
        b=GwMpeYjU0UPUDm9dz3INLUYoGdgFNUt7NzD/7SI5sYjGE+9FyhjLK01joQgS5pc+CO
         bP5DgKDTqGjtUvrNBmKSoLe5aISbyJGEu0zIV8MV9UhPRRlYEf6RXbeMgdApY8e8cGfn
         ING6er4kHFjYi/y2G6v3WloSZAuluDdJ5C/HrtyzDz3b9XtYTZnRXbur2WZM1E5Pyz4j
         u0gT5ZJrNGM1MHlb5MO3hzAlpPmzQEOyzyvT4MbhcH0kXYcChKlsQMSG5iZ9AWvuPZrp
         gglcwl5xSFxAN5s7GpN/g8AQvt7Z3tXHmjOLQlHcuxy1NKQqqxR4qMH6eTYnkz+KTmBh
         FnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=563BAybzVyHEsgNkhjo3Ec3csusCS7gRQaGdAB7Gmag=;
        b=gzVmyzwPo96zL4jubMySWXWOuGj0BTv+QtBFcGWH9obtDcwUjbU1bMfNByLKKFg+Fo
         t5IFVOrXOd21dkC5ljHc9GWVApaCrnHsh8WIr8LO9CMVDmJqcwn9GyGU2x2URoILFU6c
         qKtRUEjRUSyA10uYPjuU0SEzCcms5hIi7nXm/GA2WQoRBTnaBjPrR0L2nI5Kie+Gjwwh
         ytYkf+jSPRZNjok8s6PttgZ0BQDgXsRqClLI5RYnxy2UlBaKB138l5KygKGemV/sVH52
         0grF4b/yXtQJS50HqFDXpIZ5z2ZwC28L6cH39nqXXYUjKN/fbSLeDQdwRZNs0aWMY16H
         2zzQ==
X-Gm-Message-State: AOAM530kI0sOO/w0W0AHFGKIFVtBvpHbEJni3qzlbGRkdESwU8cz3P7n
        luJ41FnYbgnNCJCwbYmXC7StXAuSdwN5XTBHuOpoLQ==
X-Google-Smtp-Source: ABdhPJxxLImaAPwO9waG0d7jrrqrIp8kbDzYx14Qc417p4oCxS11Mr56IHANMprCOhUvN7EIWCGQjbt6ugpIv1orY34=
X-Received: by 2002:a05:6820:273:: with SMTP id c19mr993222ooe.54.1616152809948;
 Fri, 19 Mar 2021 04:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210316124118.6874-1-glittao@gmail.com> <YFM96dY1pfk/rs3U@elver.google.com>
 <3ba2228a-1442-40b4-578f-f693d9a054e7@suse.cz>
In-Reply-To: <3ba2228a-1442-40b4-578f-f693d9a054e7@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Fri, 19 Mar 2021 12:19:58 +0100
Message-ID: <CANpmjNPzO2ORHMb=WdSmZs-1k2NRzVda5rtLjvRnaGkb7xcCNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: add a kselftest for SLUB debugging functionality
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     glittao@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 19 Mar 2021 at 11:46, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 3/18/21 12:47 PM, Marco Elver wrote:
> > On Tue, Mar 16, 2021 at 01:41PM +0100, glittao@gmail.com wrote:
> >> From: Oliver Glitta <glittao@gmail.com>
> >>
> >> SLUB has resiliency_test() function which is hidden behind #ifdef
> >> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> >> runs it. Kselftest should proper replacement for it.
> >>
> >> Try changing byte in redzone after allocation and changing
> >> pointer to next free node, first byte, 50th byte and redzone
> >> byte. Check if validation finds errors.
> >>
> >> There are several differences from the original resiliency test:
> >> Tests create own caches with known state instead of corrupting
> >> shared kmalloc caches.
> >>
> >> The corruption of freepointer uses correct offset, the original
> >> resiliency test got broken with freepointer changes.
> >>
> >> Scratch changing random byte test, because it does not have
> >> meaning in this form where we need deterministic results.
> >>
> >> Add new option CONFIG_TEST_SLUB in Kconfig.
> >>
> >> Add parameter to function validate_slab_cache() to return
> >> number of errors in cache.
> >>
> >> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> >
> > No objection per-se, but have you considered a KUnit-based test instead?
>
> To be honest, we didn't realize about that option.
>
> > There is no user space portion required to run this test, and a pure
> > in-kernel KUnit test would be cleaner. Various boiler-plate below,
> > including pr_err()s, the kselftest script etc. would simply not be
> > necessary.
> >
> > This is only a suggestion, but just want to make sure you've considered
> > the option and weighed its pros/cons.
>
> Thanks for the suggestion. But I hope we would expand the tests later to e.g.
> check the contents of various SLUB related sysfs files or even write to them,
> and for that goal kselftest seems to be a better starting place?

Not sure, but I would probably go about it this way:

A. Anything that is purely in-kernel and doesn't require a user space
component should be a KUnit test.

B. For any test that requires a user space component, it'd be a kselftest.

And I think the best design here would also clearly separate those 2
types of tests, and I wouldn't lump tests of type A into modules that
are also used for B. That way, running tests of type A also is a bit
easier, and if somebody wants to just quickly run those it's e.g. very
quick to do so with kunit-tool.

Thanks,
-- Marco
