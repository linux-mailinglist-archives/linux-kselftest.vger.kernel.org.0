Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939D518E663
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 05:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgCVEbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Mar 2020 00:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgCVEbo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Mar 2020 00:31:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C77206F9;
        Sun, 22 Mar 2020 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584851503;
        bh=+5nxVvLDglesqKoMyyHWiUfsl0yEfapg6YZP612YgTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qDazwTlAD5YbbcoB54nxxYPbplX8cKKt2CJjlCy/obCgoCHH++MpPYAP3pc4Kcywz
         7PXsl5/3aOqw6vOoJu2R9yD9jFgVxWUk99JQaNYV8e3sl96XXLEUosrfazWkoATa2T
         cOHzXpoUVYrJqk3haEU/rSjFvim6ogB0js00fPcE=
Date:   Sat, 21 Mar 2020 21:31:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-Id: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
In-Reply-To: <20200322020326.GB1068248@t490s>
References: <20200322013525.1095493-1-aquini@redhat.com>
        <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
        <20200322020326.GB1068248@t490s>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> > > + * In order to sort out that race, and get the after fault checks consistent,
> > > + * the "quick and dirty" trick below is required in order to force a call to
> > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > + */
> > > +static void force_lru_add_drain_all(void)
> > > +{
> > > +	sched_yield();
> > > +	system("echo 1 > /proc/sys/vm/compact_memory");
> > > +}
> > 
> > What is the sched_yield() for?
> >
> 
> Mostly it's there to provide a sleeping gap after the fault, whithout 
> actually adding an arbitrary value with usleep(). 
> 
> It's not a hard requirement, but, in some of the tests I performed 
> (whithout that sleeping gap) I would still see around 1% chance 
> of hitting the false-negative. After adding it I could not hit
> the issue anymore.

It's concerning that such deep machinery as pagevec draining is visible
to userspace.

I suppose that for consistency and correctness we should perform a
drain prior to each read from /proc/*/pagemap.  Presumably this would
be far too expensive.

Is there any other way?  One such might be to make the MLOCK_ONFAULT
pages bypass the lru_add_pvecs?

