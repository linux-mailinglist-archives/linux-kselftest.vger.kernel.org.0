Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272F418E6C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 06:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgCVFll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Mar 2020 01:41:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57173 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbgCVFll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Mar 2020 01:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584855700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9uyrweGHZQGxIp4uBrTVmnRgE+IcgAxrg3YHUzMhEKM=;
        b=PWprG3x4fNFRNNJxVTrXJcf19+28qAvuIobe6PQYV4W2E8GaiNxAQmNTC2AI2lUp/74IG4
        lq1BwPl4DWSAXnOjHIToFjOov7Nny+49GAuPtoKXxK3pNMyjvN4hY51VDycS70Bb2MKKFL
        r7imz9ZQ7CHif3tP1dmAU06VxWcReLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-f6goE7KzM6Gu4t4Se8tiUA-1; Sun, 22 Mar 2020 01:41:36 -0400
X-MC-Unique: f6goE7KzM6Gu4t4Se8tiUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7330F8017CC;
        Sun, 22 Mar 2020 05:41:35 +0000 (UTC)
Received: from t490s (ovpn-112-50.phx2.redhat.com [10.3.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 650475DA7D;
        Sun, 22 Mar 2020 05:41:34 +0000 (UTC)
Date:   Sun, 22 Mar 2020 01:41:31 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200322054131.GC1068248@t490s>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 09:31:42PM -0700, Andrew Morton wrote:
> On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > + */
> > > > +static void force_lru_add_drain_all(void)
> > > > +{
> > > > +	sched_yield();
> > > > +	system("echo 1 > /proc/sys/vm/compact_memory");
> > > > +}
> > > 
> > > What is the sched_yield() for?
> > >
> > 
> > Mostly it's there to provide a sleeping gap after the fault, whithout 
> > actually adding an arbitrary value with usleep(). 
> > 
> > It's not a hard requirement, but, in some of the tests I performed 
> > (whithout that sleeping gap) I would still see around 1% chance 
> > of hitting the false-negative. After adding it I could not hit
> > the issue anymore.
> 
> It's concerning that such deep machinery as pagevec draining is visible
> to userspace.
> 
> I suppose that for consistency and correctness we should perform a
> drain prior to each read from /proc/*/pagemap.  Presumably this would
> be far too expensive.
> 
> Is there any other way?  One such might be to make the MLOCK_ONFAULT
> pages bypass the lru_add_pvecs?
>

Well,

I admit I wasn't taking the approach of changing the kernel because I was 
thinking it would require a partial, or even full, revert of commit 
9c4e6b1a7027f, and that would be increasing complexity, but on a 
second thought, it seems that we might just be missing:

diff --git a/mm/swap.c b/mm/swap.c
index cf39d24ada2a..b1601228ded4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -473,6 +473,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
                __mod_zone_page_state(page_zone(page), NR_MLOCK,
                                    hpage_nr_pages(page));
                count_vm_event(UNEVICTABLE_PGMLOCKED);
+               SetPageUnevictable(page);
        }
        lru_cache_add(page);
 }


I'll take a closer look into it, as well as test it properly, tomorrow. 
Thanks for the heads up, Andrew.
-- Rafael

