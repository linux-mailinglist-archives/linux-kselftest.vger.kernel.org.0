Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C518E5E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 03:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgCVCDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 22:03:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52087 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgCVCDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 22:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584842613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0oLEv6h2GsY7etmwcwb3B6JzIa6mncrHOx3tmzkR0Og=;
        b=MS5OrLk5EyGD1XDlCS6+Jw7wTIrvqSiml17fywinmm22gZqhnwJY2Oovb8P1hhBiyHhNSq
        jxb/ovz7henItus+B73rmgYWLmg+yTWM89D9d6h865cscpzcuFsmqNYkVFOydczw1RuOrK
        CoVCahdRoahZFwYeMcYvpOPQrnOlwr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-UOWmatbmNBC-pPp3B53xHg-1; Sat, 21 Mar 2020 22:03:31 -0400
X-MC-Unique: UOWmatbmNBC-pPp3B53xHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 922BC189F760;
        Sun, 22 Mar 2020 02:03:30 +0000 (UTC)
Received: from t490s (ovpn-112-44.phx2.redhat.com [10.3.112.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAF2B73884;
        Sun, 22 Mar 2020 02:03:29 +0000 (UTC)
Date:   Sat, 21 Mar 2020 22:03:26 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200322020326.GB1068248@t490s>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 06:43:52PM -0700, Andrew Morton wrote:
> On Sat, 21 Mar 2020 21:35:25 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > break this test expectations on the behavior of mlock syscall family immediately
> > inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> > passed to the syscall as part of its flag-set.
> > 
> > There is no functional error introduced by the aforementioned commit,
> > but it opens up a time window where the recently faulted and locked pages
> > might yet not be put back into the UNEVICTABLE_LRU, thus causing a
> > subsequent and immediate PFN flag check for the UNEVICTABLE bit
> > to trip on false-negative errors, as it happens with this test.
> > 
> > This patch fix the false negative by forcefully resorting to a code path that
> > will call a CPU pagevec drain right after the fault but before the PFN flag
> > check takes place, sorting out the race that way.
> > 
> >  
> > +/*
> > + * After commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > + * changes made by calls to mlock* family might not be immediately reflected
> > + * on the LRUs, thus checking the PFN flags might race against pagevec drain.
> > + *
> > + * In order to sort out that race, and get the after fault checks consistent,
> > + * the "quick and dirty" trick below is required in order to force a call to
> > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > + * the unevictable LRU, as expected by the checks in this selftest.
> > + */
> > +static void force_lru_add_drain_all(void)
> > +{
> > +	sched_yield();
> > +	system("echo 1 > /proc/sys/vm/compact_memory");
> > +}
> 
> What is the sched_yield() for?
>

Mostly it's there to provide a sleeping gap after the fault, whithout 
actually adding an arbitrary value with usleep(). 

It's not a hard requirement, but, in some of the tests I performed 
(whithout that sleeping gap) I would still see around 1% chance 
of hitting the false-negative. After adding it I could not hit
the issue anymore.

 
> >  static int onfault_check(char *map)
> >  {
> >  	unsigned long page_size = getpagesize();
> > @@ -343,6 +360,9 @@ static int onfault_check(char *map)
> >  	}
> >  
> >  	*map = 'a';
> > +
> > +	force_lru_add_drain_all();
> > +
> >  	page1_flags = get_pageflags((unsigned long)map);
> >  	page2_flags = get_pageflags((unsigned long)map + page_size);
> >  
> > @@ -465,6 +485,8 @@ static int test_lock_onfault_of_present()
> >  		goto unmap;
> >  	}
> >  
> > +	force_lru_add_drain_all();
> > +
> >  	page1_flags = get_pageflags((unsigned long)map);
> >  	page2_flags = get_pageflags((unsigned long)map + page_size);
> >  	page1_flags = get_kpageflags(page1_flags & PFN_MASK);
> 

