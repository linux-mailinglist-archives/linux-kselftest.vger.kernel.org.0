Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D953E28DCB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgJNJR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJNJR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:17:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD00C051101;
        Wed, 14 Oct 2020 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oSoCzew+YknB0dx5EoXOzxp1GOMgWSJZPnYxGNWDbHw=; b=bbHVobEMV+gxKJvM2yym+cXIBq
        fr+AXG56PjCs1dnTUCUFhA1KXpxjWdj+INB1pvURTaabIE118jh6jK8Ie8/ARC+Pmgp45nmv/ifqS
        mqDWYvAzc8+sJ/BAxkz2sVSKdNFeujBFY8Ovj+C/cNykURt2cFMx2UNiPpfD9qHUfsCmiLFejXHxP
        emit1XplFzfQI+kL4BAibB+Bb6r/6UqlL6KbtRTBCtsFKGKALZpQ7G5AGARKpVFfX42onYfwZPB/b
        F0er87EC0E3DR0lqy3cCSF/VE4aSvCn+U9OI1AMBf4CG5GRBlyMf0BFwjrx22xyBB8UuD8IQ0wcrM
        uSW/YzsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kScuP-0000Ui-V4; Wed, 14 Oct 2020 09:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46051304E03;
        Wed, 14 Oct 2020 11:17:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21495201A8541; Wed, 14 Oct 2020 11:17:20 +0200 (CEST)
Date:   Wed, 14 Oct 2020 11:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, shuah@kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
Message-ID: <20201014091720.GC2628@hirez.programming.kicks-ass.net>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
 <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 13, 2020 at 08:12:20PM -0600, Shuah Khan wrote:

> They don't add any new behavior, As Kees mentioned they do give us a
> way to clearly differentiate atomic usages that can wrap.

No it doesn't! atomic_t can wrap, this thing can wrap, no distinction.

All it does is fragment the API and sow confusion. FOR NO BENEFIT.

> > Worse, it mixes 2 unrelated cases into one type, which just makes a
> > mockery of things (all the inc_return users are not statistics, some
> > might even mis-behave if they wrap).
> > 
> 
> You are right that all inc_return usages aren't statistics. There are
> 3 distinct usages:
> 
> 1. Stats
> 2. Cases where wrapping is fine
> 3. Cases where wrapping could be a problem. In which case, this API
>    shouldn't be used.

And yet, afaict patch 4 is case 3...

> There is no need to keep inc_return in this API as such. I included it
> so it can be used for above cases 1 and 2, so the users don't have to
> call inc() followed by read(). It can be left out of the API.
> 
> The atomic_t usages in the kernel fall into the following categories:
> 
> 1. Stats (tolerance for accuracy determines whether they need to be
>    atomic or not). RFC version included non-atomic API for cases
>    when lossiness is acceptable. All these cases use/need just init
>    and inc. There are two variations in this case:
> 
>    a. No checks for wrapping. Use signed value.
>    b. No checks for wrapping, but return unsigned.
> 
> 2. Reference counters that release resource and rapping could result
>    in use-after-free type problems. There are two variations in this
>    case:
> 
>    a. Increments and decrements aren't bounded.
>    b. Increments and decrements are bounded.
> 
>    Currently tools that flag unsafe atomic_t usages that are candidates
>    for refcount_t conversions don't make a distinction between the two.
> 
>    The second case, since increments and decrements are bounded, it is
>    safe to continue to use it. At the moment there is no good way to
>    tell them apart other than looking at each of these cases.
> 
> 3. Reference counters that manage/control states. Wrapping is a problem
>    in this case, as it could lead to undefined behavior. These cases
>    don't use test and free, use inc/dec. At the moment there is no good
>    way to tell them apart other than looking at each of these cases.
>    This is addressed by REFCOUNT_SATURATED case.

Wrong! The atomic usage in mutex doesn't fall in any of those
categories.


The only thing you're all saying that makes sense is that unintentional
wrapping can have bad consequences, the rest is pure confusion.

Focus on the non-wrapping cases, _everything_ else is not going
anywhere.

So audit the kernel, find the cases that should not wrap, categorize and
create APIs for them that trap the wrapping. But don't go around
confusing things that don't need confusion.
