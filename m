Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43F218F84F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCWPNC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:13:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWPNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:13:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so2044263wmj.3;
        Mon, 23 Mar 2020 08:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLJYUtlzJQnIte12O+1TX7NShd0c3CUtv4V79jlUG84=;
        b=JGJupvO7EldIErAkGQH+3A2PbUoff+OsUf3jxHWlgUug4K4kJ5V6OYOiO2ipJSbccI
         Mszsiz24eJdP0wREB0crKDQyiPYiGhxKjWEl8zeWtbx+cNweQNZ18yN2waxuzTFm059+
         60QoGfqKG+rH5/yn739TTJ19BjPBA3dBl6W17IHOhuPIYbj0ckkNRxP3dld9gu2587B8
         p4yF1c6DWlaV7KlJhygThY/Q8Y9dbCjonH7I16HX3u3MUxBssTGPSWrze1oLxRWvqjQD
         z13zmOAryGl2z7i3FS1JoLH9IaGVvKVFYHFpRlBSrxpRRkpbRG84PLq5pIZ6GtPSo5Gj
         7NrQ==
X-Gm-Message-State: ANhLgQ1OqrlTXvR+DkW4vaQbjZeVwPAeptRCy6A7Gu10211XxStNLV5q
        39VQvBWJxpd3Q4IkbYJ9J+g=
X-Google-Smtp-Source: ADFU+vsua7OLk/30k9tXowXZF7JCw9SZSk5+/fONQ8eNrvIfByUUwexLlvp/OcSMb8/stQ4yLQvsyQ==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr27754175wmb.8.1584976379152;
        Mon, 23 Mar 2020 08:12:59 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id y7sm1335565wrq.54.2020.03.23.08.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:12:58 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:12:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323151256.GP7524@dhcp22.suse.cz>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323150259.GD23364@optiplex-lnx>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 23-03-20 11:02:59, Rafael Aquini wrote:
> On Mon, Mar 23, 2020 at 03:51:06PM +0100, Michal Hocko wrote:
> > On Mon 23-03-20 10:42:40, Rafael Aquini wrote:
> > > On Mon, Mar 23, 2020 at 08:52:08AM +0100, Michal Hocko wrote:
> > > > On Sun 22-03-20 09:36:49, Shakeel Butt wrote:
> > > > > On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > > > > >
> > > > > > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > > > > > + */
> > > > > > > > > +static void force_lru_add_drain_all(void)
> > > > > > > > > +{
> > > > > > > > > + sched_yield();
> > > > > > > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > > > > > +}
> > > > > > > >
> > > > > > > > What is the sched_yield() for?
> > > > > > > >
> > > > > > >
> > > > > > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > > > > > actually adding an arbitrary value with usleep().
> > > > > > >
> > > > > > > It's not a hard requirement, but, in some of the tests I performed
> > > > > > > (whithout that sleeping gap) I would still see around 1% chance
> > > > > > > of hitting the false-negative. After adding it I could not hit
> > > > > > > the issue anymore.
> > > > > >
> > > > > > It's concerning that such deep machinery as pagevec draining is visible
> > > > > > to userspace.
> > > > > >
> > > > > 
> > > > > We already have other examples like memcg stats where the
> > > > > optimizations like batching per-cpu stats collection exposes
> > > > > differences to the userspace. I would not be that worried here.
> > > > 
> > > > Agreed! Tests should be more tolerant for counters imprecision.
> > > > Unevictable LRU is an optimization and transition to that list is a
> > > > matter of an internal implementation detail.
> > > >
> > > > > > I suppose that for consistency and correctness we should perform a
> > > > > > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > > > > > be far too expensive.
> > > > > >
> > > > > > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > > > > > pages bypass the lru_add_pvecs?
> > > > > >
> > > > > 
> > > > > I would rather prefer to have something similar to
> > > > > /proc/sys/vm/stat_refresh which drains the pagevecs.
> > > > 
> > > > No, please don't. Pagevecs draining is by far not the only batching
> > > > scheme we use and an interface like this would promise users to
> > > > effectivelly force flushing all of them.
> > > > 
> > > > Can we simply update the test to be more tolerant to imprecisions
> > > > instead?
> > > > 
> > > 
> > > I don't think, thouhg, that this particular test case can be entirely
> > > reduced as "counter imprecison".
> > > 
> > > The reason I think this is a different beast, is that having the page
> > > being flagged as PG_unevictable is expected part of the aftermath of
> > > a mlock* call. This selftest is, IMO, correctly verifying that fact,
> > > as it checks the functionality correctness.
> > > 
> > > The problem boils down to the fact that the page would immediately
> > > be flagged as PG_unevictable after the mlock (under MCL_FUTURE|MCL_ONFAULT
> > > semantics) call, and the test was expecting it, and commit 9c4e6b1a7027f
> > > changed that by "delaying" that flag setting.
> > 
> > As I've tried to explain in other email in this email thread. The test
> > was exploiting a certain user visible side effect. The unevictable flag
> > or the placement on the unevictable LRU list is are not really needed
> > for the user contract correctness. That means that the test is not
> > really correct. Working around that by trying to enforce kernel to
> > comply with the test expectations is just plain wrong at least for two
> > reasons 1) you cannot expect or event do not want userspace to do the
> > same because the behavior might change in the future 2) the test is not
> > really testing for correctness in the first place.
> >
> 
> Sorry, Michal, it seems we keep going back and forth (I just replied to
> your comment on the other thread)
> 
> The selftest also checks the kernel visible effect, via
> /proc/kpageflags, and that's where it fails after 9c4e6b1a7027f.

I really fail to see your point. Even if you are right that the self
test is somehow evaluating the kernel implementation which I am not sure
is the scope of the selft thest but anyway. The mere fact that the
kernel test fails on a perfectly valid change should just suggest that
the test is leading to false positives and therefore should be fixed.
Your proposed fix is simply suboptimal because it relies on yet another
side effect which might change anytime in the future and still lead to a
correctly behaving kernel. See my point?

-- 
Michal Hocko
SUSE Labs
