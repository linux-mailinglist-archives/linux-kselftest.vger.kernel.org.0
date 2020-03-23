Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A218F900
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCWPy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:54:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21838 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgCWPy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584978898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aONbZkW7VTtlNQ7IX/OP6HCvxPbDTjsQv8h6JUzUnHw=;
        b=DcupFgfRD/LTA1e5rN6ma/k+cmMcZNVu9B3iwubyfX2QYPS0gJPH2ivaCgV+FxjXEUZNOM
        ibBSXqpaxa69SWBGNnJAwAMKRqg3Z2IQVPcWfjkZCleJD9CSJOzA0HNu3lfE5qS//Sto75
        rHM5a/Qjed83xCfixnZpCTpttGTJQRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8D5ohllOMACo1HLXscfZ1Q-1; Mon, 23 Mar 2020 11:54:56 -0400
X-MC-Unique: 8D5ohllOMACo1HLXscfZ1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D86F6800D54;
        Mon, 23 Mar 2020 15:54:54 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1CC919C4F;
        Mon, 23 Mar 2020 15:54:52 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:54:49 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200323155449.GG23364@optiplex-lnx>
References: <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
 <20200323075208.GC7524@dhcp22.suse.cz>
 <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
 <20200323154159.GF23364@optiplex-lnx>
 <20200323155111.GQ7524@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323155111.GQ7524@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 04:51:11PM +0100, Michal Hocko wrote:
> On Mon 23-03-20 11:41:59, Rafael Aquini wrote:
> > On Mon, Mar 23, 2020 at 04:12:56PM +0100, Michal Hocko wrote:
> > > On Mon 23-03-20 11:02:59, Rafael Aquini wrote:
> [...]
> > > > The selftest also checks the kernel visible effect, via
> > > > /proc/kpageflags, and that's where it fails after 9c4e6b1a7027f.
> > > 
> > > I really fail to see your point. Even if you are right that the self
> > > test is somehow evaluating the kernel implementation which I am not sure
> > > is the scope of the selft thest but anyway. The mere fact that the
> > > kernel test fails on a perfectly valid change should just suggest that
> > > the test is leading to false positives and therefore should be fixed.
> > > Your proposed fix is simply suboptimal because it relies on yet another
> > > side effect which might change anytime in the future and still lead to a
> > > correctly behaving kernel. See my point?
> > >
> > 
> > OK, I concede your point on the bogusness of checking the page flags in
> > this particular test and expect certain valuse there, given that no other 
> > selftest seems to be doing that level of inner kenrel detail scrutiny.
> > 
> > I'll repost this fix suggestion getting rif of those related
> > checkpoints.
> 
> Here is what I have after I had to context switch to something else
> before finishing it. Feel free to reuse if you feel like. It is likely
> to not even compile.
>

I'm OK with it, if you want to go ahead and do the kill.

Thanks 
-- Rafael

