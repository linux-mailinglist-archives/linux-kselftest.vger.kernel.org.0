Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9F18F6A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgCWORI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 10:17:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56346 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728359AbgCWORI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 10:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584973027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPIplu8ZO1Qu8lXPNUvkAqnEYJOCKO8CICL+ixcY0t0=;
        b=OnobYVrADKhwvvBoUGOVoWIgTaJgHbOX63pj8qXFgw5SzvpHUvNrH82zEogJu1KyfDWVoD
        Jls8/KfWo0SRV7p6l9CrJU8x0uV7I28n0HuMZskS/DYcn/IIJh0A6HM0dyiHVf380HvfPx
        b7lpRdJ9DLmgbuLdoMDe2LWz4T+NRug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-h64GYDNaPO6-O6mcwkvD1g-1; Mon, 23 Mar 2020 10:17:05 -0400
X-MC-Unique: h64GYDNaPO6-O6mcwkvD1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D0CCDBA7;
        Mon, 23 Mar 2020 14:17:04 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E1BD10002A7;
        Mon, 23 Mar 2020 14:17:02 +0000 (UTC)
Date:   Mon, 23 Mar 2020 10:16:59 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323141659.GA23364@optiplex-lnx>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 22, 2020 at 09:31:04AM -0700, Shakeel Butt wrote:
> On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
> >
> > Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > break this test expectations on the behavior of mlock syscall family immediately
> > inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> > passed to the syscall as part of its flag-set.
> 
> mlock* syscalls do not provide any guarantee that the pages will be in
> unevictable LRU, only that the pages will not be paged-out. The test
> is checking something very internal to the kernel and this is expected
> to break.

It was a check expected to be satisfied before the commit, though. 
Getting the mlocked pages inserted directly into the unevictable LRU,
skipping the pagevec, was established behavior before the aforementioned
commit, and even though one could argue userspace should not be aware,
or care, about such inner kernel circles the program in question is not an 
ordinary userspace app, but a kernel selftest that is supposed to check
for the functionality correctness.

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
> > Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> 
> This is fixing the actual test and not about fixing the mentioned
> patch. So, this Fixes line is not needed.
>

If one bisects the kernel looking for the patch that causes the selftest
to fail that commit is going to show up as the issue, thus the reference.

