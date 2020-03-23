Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32518F83E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCWPII (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:08:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20759 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgCWPII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584976086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boyhvrzOtDio58DSfyyVO/3598sZBoxhLyRpe5w9LWs=;
        b=ALcTYJEKb+LWeqWEBtcVlB4Hj1KPLjWoP+1a8roj2i6u5hmSlLY6iZW95wlCCqccKGjhgV
        poMMUadkqAuZ9vdNqzhQUvftE2Q4YvtGsgRcn1bNHyzk9oqgZ+cJ3ydkQVcOcH0zBpBNL4
        iZcFO3eg587Hfugit2xOc+SHmnmievI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Nc8wrUQJMRuUCpd_uzXOxw-1; Mon, 23 Mar 2020 11:08:02 -0400
X-MC-Unique: Nc8wrUQJMRuUCpd_uzXOxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858158017CC;
        Mon, 23 Mar 2020 15:08:01 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EDA460BE0;
        Mon, 23 Mar 2020 15:07:59 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:07:56 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323150756.GE23364@optiplex-lnx>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
 <20200323141659.GA23364@optiplex-lnx>
 <20200323142941.GK7524@dhcp22.suse.cz>
 <20200323150134.GN7524@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323150134.GN7524@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 04:01:34PM +0100, Michal Hocko wrote:
> On Mon 23-03-20 15:29:43, Michal Hocko wrote:
> > On Mon 23-03-20 10:16:59, Rafael Aquini wrote:
> > > On Sun, Mar 22, 2020 at 09:31:04AM -0700, Shakeel Butt wrote:
> > > > On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
> > > > >
> > > > > Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> > > > > break this test expectations on the behavior of mlock syscall family immediately
> > > > > inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> > > > > passed to the syscall as part of its flag-set.
> > > > 
> > > > mlock* syscalls do not provide any guarantee that the pages will be in
> > > > unevictable LRU, only that the pages will not be paged-out. The test
> > > > is checking something very internal to the kernel and this is expected
> > > > to break.
> > > 
> > > It was a check expected to be satisfied before the commit, though. 
> > > Getting the mlocked pages inserted directly into the unevictable LRU,
> > > skipping the pagevec, was established behavior before the aforementioned
> > > commit, and even though one could argue userspace should not be aware,
> > > or care, about such inner kernel circles the program in question is not an 
> > > ordinary userspace app, but a kernel selftest that is supposed to check
> > > for the functionality correctness.
> > 
> > But mlock (in neither mode) is reall forced to put pages to the
> 
> ble I meant to say "is not really forced"
> 
> > UNEVICTABLE_LRU for correctness. If the test is really depending on it
> > then the selftest is bogus. A real MCL_ONFAULT test should focus on the
> > user observable contract of this api. And that is that a new mapping
> > doesn't fault in the page during the mlock call but the memory is locked
> > after the memory is faulted in. You can use different methods to observe
> > locked memory - e.g. try to reclaim it and check or check /proc/<pid>/smaps
> 
> I have just checked the testcase and I believe it is really dubious to
> check for page flags. Those are really an internal implementation
> detail. All the available information is available in the
> /proc/<pid>/smaps file which is already parsed in the test so the test
> is easily fixable.

That surely is another take for this test. 
I still think the test is reasonable when it checks what was 
expected to be there, from the kernel standpoint, and just needs
to be adjusted for the current state of affairs.

-- Rafael

