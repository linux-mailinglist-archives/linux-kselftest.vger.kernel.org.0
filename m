Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A232161FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGFXRo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGFXRn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 19:17:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D5C061755
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 16:17:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w34so10341235qte.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2sglXry6jo5WC9tGPTwvrNF+qD0AVoMKVqa+0CTOIi0=;
        b=KILjDNzuGOpXNi72Brj1eM5SM+kb0VyYxN6pP6U5fcVC0rzt6TDO+3LBjTStWY3Omd
         U/8J/sfpJea1srFKBivdwA18Opgl2vZz5i3xoPIkR7+cWkwGesLlVq2Ivomr7vrl3/l9
         Ro3z5Q/jVylYpYgMrdKj4Saqrss4P3yQnbI0zX2NUESdE8kGd8xVh6QzRGHendBFlunD
         enH87QXPJRGMr1L+uYn3XcAZ0KYrhtW2rpNYOiUX57uhiEhAQ77Rucod1nxI/gQ7QCyb
         ZNW4uZTioXwFNoDTAsyX6+F1fDWqWaGJ4UVXJxb4kjuvoy3U7QQRAVBHISdA+T1g/nhL
         09gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sglXry6jo5WC9tGPTwvrNF+qD0AVoMKVqa+0CTOIi0=;
        b=NuCEpNm60PYuFZm6lM2pYyJqqnBO3SuNR6bj+6n8wYByThVIYVztJcxLidXiwdAt71
         d3GJb3JUs+2s8bfEL1a56tdP1eRSQBUtlRCL2AeEtN6kVQx0xkQbA5iPqrOYFPjQjXaI
         BBtEOuBJvb8TachyCSVxov5vHYYvi/79NPsZI+z1Q3ptCk6Ci/5auKqZvPE4jk7j+nxz
         Xdfjbmkuc89BCeTZvtrFFj7n6bZLGRCwqroWwp7Caz4nMSKrRcHt/KOkgxmiSZ46Eccy
         X7szRPR0MRDrDJiBZmIDp60nagKjS3ZCRWVSHduZ2sCIA9FApb0RfUCDKnz0Y4tX7Ca3
         EffQ==
X-Gm-Message-State: AOAM532uTUa+uLTeEoBJk+jukNI5WpZTy1UWXDFIzAnVcqIKv6HC5MZn
        PjOrwdDBMieiKc6nKb4lCNcRf7Ykfh9t7g==
X-Google-Smtp-Source: ABdhPJz97wFFwDc7i32KwOmULkcqoaqliBs417MqBraN5Byviha0CDW3/uiGNFs0AJfcfxxxhQgWDg==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr52178105qtj.78.1594077462157;
        Mon, 06 Jul 2020 16:17:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j18sm25466554qko.95.2020.07.06.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:17:41 -0700 (PDT)
Date:   Mon, 6 Jul 2020 19:17:30 -0400
From:   Qian Cai <cai@lca.pw>
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kunit: kmemleak integration
Message-ID: <20200706231730.GA2613@lca.pw>
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
 <20200706211309.3314644-3-urielguajardojr@gmail.com>
 <20200706213905.GA1916@lca.pw>
 <CAG30EeeV0c8vQCdtqPBUNMiN--0K+j5xE+PMwW-godhX1qqwQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG30EeeV0c8vQCdtqPBUNMiN--0K+j5xE+PMwW-godhX1qqwQg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 05:48:21PM -0500, Uriel Guajardo wrote:
> On Mon, Jul 6, 2020 at 4:39 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Mon, Jul 06, 2020 at 09:13:09PM +0000, Uriel Guajardo wrote:
> > > From: Uriel Guajardo <urielguajardo@google.com>
> > >
> > > Integrate kmemleak into the KUnit testing framework.
> > >
> > > Kmemleak will now fail the currently running KUnit test case if it finds
> > > any memory leaks.
> > >
> > > The minimum object age for reporting is set to 0 msecs so that leaks are
> > > not ignored if the test case finishes too quickly.
> > >
> > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > ---
> > >  include/linux/kmemleak.h | 11 +++++++++++
> > >  lib/Kconfig.debug        | 26 ++++++++++++++++++++++++++
> > >  lib/kunit/test.c         | 36 +++++++++++++++++++++++++++++++++++-
> > >  mm/kmemleak.c            | 27 +++++++++++++++++++++------
> > >  4 files changed, 93 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
> > > index 34684b2026ab..0da427934462 100644
> > > --- a/include/linux/kmemleak.h
> > > +++ b/include/linux/kmemleak.h
> > > @@ -35,6 +35,10 @@ extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
> > >  extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
> > >  extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
> > >
> > > +extern ssize_t kmemleak_write(struct file *file,
> > > +                           const char __user *user_buf,
> > > +                           size_t size, loff_t *ppos);
> > > +
> > >  static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
> > >                                           int min_count, slab_flags_t flags,
> > >                                           gfp_t gfp)
> > > @@ -120,6 +124,13 @@ static inline void kmemleak_ignore_phys(phys_addr_t phys)
> > >  {
> > >  }
> > >
> > > +static inline ssize_t kmemleak_write(struct file *file,
> > > +                                  const char __user *user_buf,
> > > +                                  size_t size, loff_t *ppos)
> > > +{
> > > +     return -1;
> > > +}
> > > +
> > >  #endif       /* CONFIG_DEBUG_KMEMLEAK */
> > >
> > >  #endif       /* __KMEMLEAK_H */
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 21d9c5f6e7ec..e9c492cb3f4d 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -602,6 +602,32 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> > >         fully initialised, this memory pool acts as an emergency one
> > >         if slab allocations fail.
> > >
> > > +config DEBUG_KMEMLEAK_MAX_TRACE
> > > +     int "Kmemleak stack trace length"
> > > +     depends on DEBUG_KMEMLEAK
> > > +     default 16
> > > +
> > > +config DEBUG_KMEMLEAK_MSECS_MIN_AGE
> > > +     int "Minimum object age before reporting in msecs"
> > > +     depends on DEBUG_KMEMLEAK
> > > +     default 0 if KUNIT
> > > +     default 5000
> > > +
> > > +config DEBUG_KMEMLEAK_SECS_FIRST_SCAN
> > > +     int "Delay before first scan in secs"
> > > +     depends on DEBUG_KMEMLEAK
> > > +     default 60
> > > +
> > > +config DEBUG_KMEMLEAK_SECS_SCAN_WAIT
> > > +     int "Delay before subsequent auto scans in secs"
> > > +     depends on DEBUG_KMEMLEAK
> > > +     default 600
> > > +
> > > +config DEBUG_KMEMLEAK_MAX_SCAN_SIZE
> > > +     int "Maximum size of scanned block"
> > > +     depends on DEBUG_KMEMLEAK
> > > +     default 4096
> > > +
> >
> > Why do you make those configurable? I don't see anywhere you make use of
> > them except DEBUG_KMEMLEAK_MSECS_MIN_AGE?
> >
> 
> That's correct. Strictly speaking, only DEBUG_KMEMLEAK_MSECS_MIN_AGE
> is used to set a default when KUnit is configured.
> 
> There is no concrete reason why these other variables need to be
> configurable. At the time of writing this, it seemed to make the most
> sense to configure the other configuration options, given that I was
> already going to make MSECS_MIN_AGE configurable. It can definitely be
> taken out.
> 
> > Even then, how setting DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 not giving too
> > many false positives? Kmemleak simply does not work that instantly.
> >
> 
> I did not experience this issue, but I see your point.
> 
> An alternative that I was thinking about -- and one that is not in
> this patch -- is to wait DEBUG_KMEMLEAK_MSECS_MIN_AGE after each test
> case in a test suite, while leaving kmemleak's default value as is. I
> was hesitant to do this initially because many KUnit test cases run
> quick, so this may result in a lot of time just waiting. But if we
> leave it configurable, the user can change this as needed and deal
> with the possible false positives.

I doubt that is good idea. We don't really want people to start
reporting those false positives to the MLs just because some kunit tests
starts to flag them. It is wasting everyone's time. Reports from
DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 are simply trustful. I don't think there
is a way around. Kmemleak was designed to have a lot of
waitings/re-scans to be useful not even mentioning kfree_rcu() etc until
it is redesigned...
