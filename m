Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1042177FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 21:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGTel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGTel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 15:34:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39501C061755
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 12:34:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so39236703qkg.12
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVt2YK5fz9oFkXUBAkGsBYne4Pd79jtYdQyRepPOP4E=;
        b=XyYCfoXM1r+N8DwUWlmvDPLAfgaaXeOLfy8C4mRQZYkYvPG6MAbu06xw7R2KfFrbf2
         QpPdS9/4cRY8r7GCHNdjwKLcFvlmDAW1zk8eI2EGfl27V61Wp2IgJZDOkB2Wtg9Yi+Lw
         tpavHoYcteHAqlcmnGtrYxOIuFGQPDUReDUUC/KYUdABDh0KTVeT0xmR1nUk/BBdTQUK
         Ahpn+v3vPLCsce+dJFsewCeqrtt5r2pSMiewHfeJ9MyW5qS7hstGyz9m9o9vk9JRx/EY
         AKGQ1B/NO92bS7DUmzTH47kc23GpDWSIbymOwI5Y/VaqT2bd5zL199G52/+/3yv36PPF
         ARHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVt2YK5fz9oFkXUBAkGsBYne4Pd79jtYdQyRepPOP4E=;
        b=RJOroGa7BcDvZR7cIx08QhHYaUBtDXttgdaffNUSOfxTbIaTEYao0PAwEajHzXVt0a
         yVHLtWaJwYBssmX/da/SpIP7148Hu2GSg173Uw+W3A/LL7dfxk3wdM5vBuXMPEErTzQS
         aRbj4rqJxCvXqmvJEg9GtiQlnRFS5PBQzAx3J+JbmFtT8+tGq/zVHoFDUj/A+XbuZ6US
         OAMtTFEehE1bYoolsA6sQN8cH4UArHaGSD0hav2BdLAi90F4PrdymEP/DXAcVZJKiHU+
         VfY6o3j1uNv2YE0ILPiYJBI+NMjlLLM6aXgHLg0UjtURajbt+csnsqsHEg281X7N3kWL
         Fzwg==
X-Gm-Message-State: AOAM531F06h8qHm+/MU2EXMW/iT2QPZ0NdpCUPcM0sBXDHwXyp2UeJ3w
        W1/bhgXAZdxQ4Pmoh99IYQA/9A==
X-Google-Smtp-Source: ABdhPJxWnRfHlcB33n2WqGOiUJ8zUyEBAGcI/XOi8NRXNTu75pauGmptq+erFObPZ0B0CEYsYn8y+w==
X-Received: by 2002:ae9:e809:: with SMTP id a9mr52315940qkg.315.1594150480267;
        Tue, 07 Jul 2020 12:34:40 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l31sm22808139qtc.33.2020.07.07.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 12:34:39 -0700 (PDT)
Date:   Tue, 7 Jul 2020 15:34:37 -0400
From:   Qian Cai <cai@lca.pw>
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, masahiroy@kernel.org, 0x7f454c46@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kunit: kmemleak integration
Message-ID: <20200707193437.GB992@lca.pw>
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
 <20200706211309.3314644-3-urielguajardojr@gmail.com>
 <20200706213905.GA1916@lca.pw>
 <CAG30EeeV0c8vQCdtqPBUNMiN--0K+j5xE+PMwW-godhX1qqwQg@mail.gmail.com>
 <20200706231730.GA2613@lca.pw>
 <CAG30EeeJL_LUpZdBYpi4TRhw8pzBxhSrVF-4j1g3z22-ZXTGrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG30EeeJL_LUpZdBYpi4TRhw8pzBxhSrVF-4j1g3z22-ZXTGrw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 07, 2020 at 12:26:52PM -0500, Uriel Guajardo wrote:
> On Mon, Jul 6, 2020 at 6:17 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Mon, Jul 06, 2020 at 05:48:21PM -0500, Uriel Guajardo wrote:
> > > On Mon, Jul 6, 2020 at 4:39 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > On Mon, Jul 06, 2020 at 09:13:09PM +0000, Uriel Guajardo wrote:
> > > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > > >
> > > > > Integrate kmemleak into the KUnit testing framework.
> > > > >
> > > > > Kmemleak will now fail the currently running KUnit test case if it finds
> > > > > any memory leaks.
> > > > >
> > > > > The minimum object age for reporting is set to 0 msecs so that leaks are
> > > > > not ignored if the test case finishes too quickly.
> > > > >
> > > > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > > > ---
> > > > >  include/linux/kmemleak.h | 11 +++++++++++
> > > > >  lib/Kconfig.debug        | 26 ++++++++++++++++++++++++++
> > > > >  lib/kunit/test.c         | 36 +++++++++++++++++++++++++++++++++++-
> > > > >  mm/kmemleak.c            | 27 +++++++++++++++++++++------
> > > > >  4 files changed, 93 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
> > > > > index 34684b2026ab..0da427934462 100644
> > > > > --- a/include/linux/kmemleak.h
> > > > > +++ b/include/linux/kmemleak.h
> > > > > @@ -35,6 +35,10 @@ extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
> > > > >  extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
> > > > >  extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
> > > > >
> > > > > +extern ssize_t kmemleak_write(struct file *file,
> > > > > +                           const char __user *user_buf,
> > > > > +                           size_t size, loff_t *ppos);
> > > > > +
> > > > >  static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
> > > > >                                           int min_count, slab_flags_t flags,
> > > > >                                           gfp_t gfp)
> > > > > @@ -120,6 +124,13 @@ static inline void kmemleak_ignore_phys(phys_addr_t phys)
> > > > >  {
> > > > >  }
> > > > >
> > > > > +static inline ssize_t kmemleak_write(struct file *file,
> > > > > +                                  const char __user *user_buf,
> > > > > +                                  size_t size, loff_t *ppos)
> > > > > +{
> > > > > +     return -1;
> > > > > +}
> > > > > +
> > > > >  #endif       /* CONFIG_DEBUG_KMEMLEAK */
> > > > >
> > > > >  #endif       /* __KMEMLEAK_H */
> > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > index 21d9c5f6e7ec..e9c492cb3f4d 100644
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -602,6 +602,32 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> > > > >         fully initialised, this memory pool acts as an emergency one
> > > > >         if slab allocations fail.
> > > > >
> > > > > +config DEBUG_KMEMLEAK_MAX_TRACE
> > > > > +     int "Kmemleak stack trace length"
> > > > > +     depends on DEBUG_KMEMLEAK
> > > > > +     default 16
> > > > > +
> > > > > +config DEBUG_KMEMLEAK_MSECS_MIN_AGE
> > > > > +     int "Minimum object age before reporting in msecs"
> > > > > +     depends on DEBUG_KMEMLEAK
> > > > > +     default 0 if KUNIT
> > > > > +     default 5000
> > > > > +
> > > > > +config DEBUG_KMEMLEAK_SECS_FIRST_SCAN
> > > > > +     int "Delay before first scan in secs"
> > > > > +     depends on DEBUG_KMEMLEAK
> > > > > +     default 60
> > > > > +
> > > > > +config DEBUG_KMEMLEAK_SECS_SCAN_WAIT
> > > > > +     int "Delay before subsequent auto scans in secs"
> > > > > +     depends on DEBUG_KMEMLEAK
> > > > > +     default 600
> > > > > +
> > > > > +config DEBUG_KMEMLEAK_MAX_SCAN_SIZE
> > > > > +     int "Maximum size of scanned block"
> > > > > +     depends on DEBUG_KMEMLEAK
> > > > > +     default 4096
> > > > > +
> > > >
> > > > Why do you make those configurable? I don't see anywhere you make use of
> > > > them except DEBUG_KMEMLEAK_MSECS_MIN_AGE?
> > > >
> > >
> > > That's correct. Strictly speaking, only DEBUG_KMEMLEAK_MSECS_MIN_AGE
> > > is used to set a default when KUnit is configured.
> > >
> > > There is no concrete reason why these other variables need to be
> > > configurable. At the time of writing this, it seemed to make the most
> > > sense to configure the other configuration options, given that I was
> > > already going to make MSECS_MIN_AGE configurable. It can definitely be
> > > taken out.
> > >
> > > > Even then, how setting DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 not giving too
> > > > many false positives? Kmemleak simply does not work that instantly.
> > > >
> > >
> > > I did not experience this issue, but I see your point.
> > >
> > > An alternative that I was thinking about -- and one that is not in
> > > this patch -- is to wait DEBUG_KMEMLEAK_MSECS_MIN_AGE after each test
> > > case in a test suite, while leaving kmemleak's default value as is. I
> > > was hesitant to do this initially because many KUnit test cases run
> > > quick, so this may result in a lot of time just waiting. But if we
> > > leave it configurable, the user can change this as needed and deal
> > > with the possible false positives.
> >
> > I doubt that is good idea. We don't really want people to start
> > reporting those false positives to the MLs just because some kunit tests
> > starts to flag them. It is wasting everyone's time. Reports from
> > DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 are simply trustful. I don't think there
> > is a way around. Kmemleak was designed to have a lot of
> > waitings/re-scans to be useful not even mentioning kfree_rcu() etc until
> > it is redesigned...
> 
> I agree with your statement about false positives.
> Is your suggestion to not make MSECS_MIN_AGE configurable and have
> KUnit wait after each test case? Or are you saying that this will not
> work entirely?
> It seems like kmemleak should be able to work in some fashion under
> KUnit, since it has specific documentation over testing parts of code
> (https://www.kernel.org/doc/html/latest/dev-tools/kmemleak.html#testing-specific-sections-with-kmemleak).

It is going to be tough. It is normal that sometimes when there is a
leak. It needs to rescan a few times to make sure it is stable.
Sometimes, even the real leaks will take quite a while to show up.
