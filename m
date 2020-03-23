Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5994818F720
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCWOmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 10:42:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29534 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgCWOmw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 10:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584974570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmqufm0XIBzHOIeOpsr7SvuIMRay/BSooAZ86ryWfTY=;
        b=ed3nDkcEnpNiYETnn1iktzzDsiMDy+JcDLCUfo+UJmxtcLv878BKsAqNiZCwGfrQiOSoke
        R7F21sLHPvfRMU+Y3McOE8ot4GJIuVNxK+0KXG/BWdQ9grAViJzkQGPJdq0dYkG8iyzNMn
        KYc5j/VkwnPLYgx2953MBLjBFZj4Fl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ubSL_eP_Nu21TQnnl7LeKQ-1; Mon, 23 Mar 2020 10:42:47 -0400
X-MC-Unique: ubSL_eP_Nu21TQnnl7LeKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7485FA0CC0;
        Mon, 23 Mar 2020 14:42:45 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9529760BE2;
        Mon, 23 Mar 2020 14:42:43 +0000 (UTC)
Date:   Mon, 23 Mar 2020 10:42:40 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323144240.GB23364@optiplex-lnx>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323075208.GC7524@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 08:52:08AM +0100, Michal Hocko wrote:
> On Sun 22-03-20 09:36:49, Shakeel Butt wrote:
> > On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > >
> > > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > > + */
> > > > > > +static void force_lru_add_drain_all(void)
> > > > > > +{
> > > > > > + sched_yield();
> > > > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > > +}
> > > > >
> > > > > What is the sched_yield() for?
> > > > >
> > > >
> > > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > > actually adding an arbitrary value with usleep().
> > > >
> > > > It's not a hard requirement, but, in some of the tests I performed
> > > > (whithout that sleeping gap) I would still see around 1% chance
> > > > of hitting the false-negative. After adding it I could not hit
> > > > the issue anymore.
> > >
> > > It's concerning that such deep machinery as pagevec draining is visible
> > > to userspace.
> > >
> > 
> > We already have other examples like memcg stats where the
> > optimizations like batching per-cpu stats collection exposes
> > differences to the userspace. I would not be that worried here.
> 
> Agreed! Tests should be more tolerant for counters imprecision.
> Unevictable LRU is an optimization and transition to that list is a
> matter of an internal implementation detail.
>
> > > I suppose that for consistency and correctness we should perform a
> > > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > > be far too expensive.
> > >
> > > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > > pages bypass the lru_add_pvecs?
> > >
> > 
> > I would rather prefer to have something similar to
> > /proc/sys/vm/stat_refresh which drains the pagevecs.
> 
> No, please don't. Pagevecs draining is by far not the only batching
> scheme we use and an interface like this would promise users to
> effectivelly force flushing all of them.
> 
> Can we simply update the test to be more tolerant to imprecisions
> instead?
> 

I don't think, thouhg, that this particular test case can be entirely
reduced as "counter imprecison".

The reason I think this is a different beast, is that having the page
being flagged as PG_unevictable is expected part of the aftermath of
a mlock* call. This selftest is, IMO, correctly verifying that fact,
as it checks the functionality correctness.

The problem boils down to the fact that the page would immediately
be flagged as PG_unevictable after the mlock (under MCL_FUTURE|MCL_ONFAULT
semantics) call, and the test was expecting it, and commit 9c4e6b1a7027f
changed that by "delaying" that flag setting.

As I mentioned, too, there's nothing wrong with the delayed setting of 
PG_unevictable, we just need to compensate for that fact in this test,
which is what this patch is suggesting to do.
  
> -- 
> Michal Hocko
> SUSE Labs
> 

