Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E3018F8D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCWPmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:42:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57614 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbgCWPmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584978130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2aDqCcSfB/xh/vKuPI7ZlBqpkn3r4YZxQ0+rlPhEEI=;
        b=cvJJur4GLJrkJMsUNwajJQT+AA3jfc1zYBTxUiWt17Db8SBjegQq/3Elt2LNQSqYfmyXOo
        QTLZsitFXhZYBMK0pl9WRg2zDXzPdrDpP0Jfpce7+2xRAY+uQNtexg85q3wGvGbsnsufFd
        kw372mQsogb13ZBelXWlnEs7AmGBT/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-9WCHLGyOPG-VWuxUZDIHKA-1; Mon, 23 Mar 2020 11:42:05 -0400
X-MC-Unique: 9WCHLGyOPG-VWuxUZDIHKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 772E6800D50;
        Mon, 23 Mar 2020 15:42:04 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 999D65C1B2;
        Mon, 23 Mar 2020 15:42:02 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:41:59 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323154159.GF23364@optiplex-lnx>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323151256.GP7524@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 04:12:56PM +0100, Michal Hocko wrote:
> On Mon 23-03-20 11:02:59, Rafael Aquini wrote:
> > On Mon, Mar 23, 2020 at 03:51:06PM +0100, Michal Hocko wrote:
> > > On Mon 23-03-20 10:42:40, Rafael Aquini wrote:
> > > > On Mon, Mar 23, 2020 at 08:52:08AM +0100, Michal Hocko wrote:
> > > > > On Sun 22-03-20 09:36:49, Shakeel Butt wrote:
> > > > > > On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > > >
> > > > > > > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > > > > > >
> > > > > > > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > > > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > > > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > > > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > > > > > > + */
> > > > > > > > > > +static void force_lru_add_drain_all(void)
> > > > > > > > > > +{
> > > > > > > > > > + sched_yield();
> > > > > > > > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > > > > > > +}
> > > > > > > > >
> > > > > > > > > What is the sched_yield() for?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > > > > > > actually adding an arbitrary value with usleep().
> > > > > > > >
> > > > > > > > It's not a hard requirement, but, in some of the tests I performed
> > > > > > > > (whithout that sleeping gap) I would still see around 1% chance
> > > > > > > > of hitting the false-negative. After adding it I could not hit
> > > > > > > > the issue anymore.
> > > > > > >
> > > > > > > It's concerning that such deep machinery as pagevec draining is visible
> > > > > > > to userspace.
> > > > > > >
> > > > > > 
> > > > > > We already have other examples like memcg stats where the
> > > > > > optimizations like batching per-cpu stats collection exposes
> > > > > > differences to the userspace. I would not be that worried here.
> > > > > 
> > > > > Agreed! Tests should be more tolerant for counters imprecision.
> > > > > Unevictable LRU is an optimization and transition to that list is a
> > > > > matter of an internal implementation detail.
> > > > >
> > > > > > > I suppose that for consistency and correctness we should perform a
> > > > > > > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > > > > > > be far too expensive.
> > > > > > >
> > > > > > > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > > > > > > pages bypass the lru_add_pvecs?
> > > > > > >
> > > > > > 
> > > > > > I would rather prefer to have something similar to
> > > > > > /proc/sys/vm/stat_refresh which drains the pagevecs.
> > > > > 
> > > > > No, please don't. Pagevecs draining is by far not the only batching
> > > > > scheme we use and an interface like this would promise users to
> > > > > effectivelly force flushing all of them.
> > > > > 
> > > > > Can we simply update the test to be more tolerant to imprecisions
> > > > > instead?
> > > > > 
> > > > 
> > > > I don't think, thouhg, that this particular test case can be entirely
> > > > reduced as "counter imprecison".
> > > > 
> > > > The reason I think this is a different beast, is that having the page
> > > > being flagged as PG_unevictable is expected part of the aftermath of
> > > > a mlock* call. This selftest is, IMO, correctly verifying that fact,
> > > > as it checks the functionality correctness.
> > > > 
> > > > The problem boils down to the fact that the page would immediately
> > > > be flagged as PG_unevictable after the mlock (under MCL_FUTURE|MCL_ONFAULT
> > > > semantics) call, and the test was expecting it, and commit 9c4e6b1a7027f
> > > > changed that by "delaying" that flag setting.
> > > 
> > > As I've tried to explain in other email in this email thread. The test
> > > was exploiting a certain user visible side effect. The unevictable flag
> > > or the placement on the unevictable LRU list is are not really needed
> > > for the user contract correctness. That means that the test is not
> > > really correct. Working around that by trying to enforce kernel to
> > > comply with the test expectations is just plain wrong at least for two
> > > reasons 1) you cannot expect or event do not want userspace to do the
> > > same because the behavior might change in the future 2) the test is not
> > > really testing for correctness in the first place.
> > >
> > 
> > Sorry, Michal, it seems we keep going back and forth (I just replied to
> > your comment on the other thread)
> > 
> > The selftest also checks the kernel visible effect, via
> > /proc/kpageflags, and that's where it fails after 9c4e6b1a7027f.
> 
> I really fail to see your point. Even if you are right that the self
> test is somehow evaluating the kernel implementation which I am not sure
> is the scope of the selft thest but anyway. The mere fact that the
> kernel test fails on a perfectly valid change should just suggest that
> the test is leading to false positives and therefore should be fixed.
> Your proposed fix is simply suboptimal because it relies on yet another
> side effect which might change anytime in the future and still lead to a
> correctly behaving kernel. See my point?
>

OK, I concede your point on the bogusness of checking the page flags in
this particular test and expect certain valuse there, given that no other 
selftest seems to be doing that level of inner kenrel detail scrutiny.

I'll repost this fix suggestion getting rif of those related
checkpoints.

Cheers!
-- Rafael

