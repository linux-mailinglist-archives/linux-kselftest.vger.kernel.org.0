Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD418F770
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCWOvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 10:51:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37349 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCWOvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 10:51:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id d1so15131700wmb.2;
        Mon, 23 Mar 2020 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6p44xGwV8r9hc9Uqd5WPQ5phNN16MgM5x4v+o5mOS6U=;
        b=XyQwvJ6anCbzIRyAA7M+eMaVsdn9MGlBGQP8IRpD8QCqgYK+GM4oEGShYwuSTVy9q4
         17Bt8aghls7M3FXJ74jfwX3tog7rmRFnJp52ZMGTfEfF14EC0OlZS3GHxZK1M/fvVHgR
         +nQzSQFL5UAwMaGlOCUWkZNtwTjI9CtiRk5KvAH/pfXafc/ejgPhbnIyZxkTYSPtXS1e
         gY0Rs4wZbHbC+Zjl/mc3yQ279tZqz1rI5afxREfvayCC85fDpsKbVIiZorVCZ9FxQhTg
         RachXiyQzrGBwDOatErUv+jKgwpn9Mmu9GqBpaG6AXtz1hrNEaelKHQu660pv0humh+h
         Ztzw==
X-Gm-Message-State: ANhLgQ1omInGi0JObneZ/8EAWWwpMDrJ98g9Nm6EbyHehywTj25OU8RW
        2aAT9MLgRSBMtqZNpK1Osns=
X-Google-Smtp-Source: ADFU+vs1QCZ8mprUzpnIwn0V7v7uPGzQF2aNNIK0lD5/s6jZbaVReZ7/bEP7h33glQ0k1aRiTKO4mg==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr25533395wmf.157.1584975071478;
        Mon, 23 Mar 2020 07:51:11 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id x24sm21883617wmc.36.2020.03.23.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 07:51:10 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:51:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323145106.GM7524@dhcp22.suse.cz>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323144240.GB23364@optiplex-lnx>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 23-03-20 10:42:40, Rafael Aquini wrote:
> On Mon, Mar 23, 2020 at 08:52:08AM +0100, Michal Hocko wrote:
> > On Sun 22-03-20 09:36:49, Shakeel Butt wrote:
> > > On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > > >
> > > > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > > > + */
> > > > > > > +static void force_lru_add_drain_all(void)
> > > > > > > +{
> > > > > > > + sched_yield();
> > > > > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > > > +}
> > > > > >
> > > > > > What is the sched_yield() for?
> > > > > >
> > > > >
> > > > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > > > actually adding an arbitrary value with usleep().
> > > > >
> > > > > It's not a hard requirement, but, in some of the tests I performed
> > > > > (whithout that sleeping gap) I would still see around 1% chance
> > > > > of hitting the false-negative. After adding it I could not hit
> > > > > the issue anymore.
> > > >
> > > > It's concerning that such deep machinery as pagevec draining is visible
> > > > to userspace.
> > > >
> > > 
> > > We already have other examples like memcg stats where the
> > > optimizations like batching per-cpu stats collection exposes
> > > differences to the userspace. I would not be that worried here.
> > 
> > Agreed! Tests should be more tolerant for counters imprecision.
> > Unevictable LRU is an optimization and transition to that list is a
> > matter of an internal implementation detail.
> >
> > > > I suppose that for consistency and correctness we should perform a
> > > > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > > > be far too expensive.
> > > >
> > > > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > > > pages bypass the lru_add_pvecs?
> > > >
> > > 
> > > I would rather prefer to have something similar to
> > > /proc/sys/vm/stat_refresh which drains the pagevecs.
> > 
> > No, please don't. Pagevecs draining is by far not the only batching
> > scheme we use and an interface like this would promise users to
> > effectivelly force flushing all of them.
> > 
> > Can we simply update the test to be more tolerant to imprecisions
> > instead?
> > 
> 
> I don't think, thouhg, that this particular test case can be entirely
> reduced as "counter imprecison".
> 
> The reason I think this is a different beast, is that having the page
> being flagged as PG_unevictable is expected part of the aftermath of
> a mlock* call. This selftest is, IMO, correctly verifying that fact,
> as it checks the functionality correctness.
> 
> The problem boils down to the fact that the page would immediately
> be flagged as PG_unevictable after the mlock (under MCL_FUTURE|MCL_ONFAULT
> semantics) call, and the test was expecting it, and commit 9c4e6b1a7027f
> changed that by "delaying" that flag setting.

As I've tried to explain in other email in this email thread. The test
was exploiting a certain user visible side effect. The unevictable flag
or the placement on the unevictable LRU list is are not really needed
for the user contract correctness. That means that the test is not
really correct. Working around that by trying to enforce kernel to
comply with the test expectations is just plain wrong at least for two
reasons 1) you cannot expect or event do not want userspace to do the
same because the behavior might change in the future 2) the test is not
really testing for correctness in the first place.

-- 
Michal Hocko
SUSE Labs
