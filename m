Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0408428EAA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgJOCAH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 22:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgJOB7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D98C08EC73
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:31:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so780033pff.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXVUBRNSSqTPt62/mgLGqwfLQyF1yjV/YHL73Dao6W8=;
        b=jCAqi4iTXHmrlmTxFYn6GS2VgUo/8myl3KBrmWg0lRxHbNQgb3vs1osYENVe61bW0P
         M+4wkDUWjW0myaMTX5a1Gxf50PJCa/e+uOHI7EyM+POftZ0Y/9LfYtXSwlA+pbBlCT0Z
         p+qpDy78UxHceaiLraq0fP4f7UgNDPeMM5qHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXVUBRNSSqTPt62/mgLGqwfLQyF1yjV/YHL73Dao6W8=;
        b=oVpIlbTLuHd+z0HYiqgIW+VP9zWHD0PwWIejovfG48Q7ZfuF8BIyTwCgURLD9rIXgP
         YtHaVcJLNZJrTtBoc/ii1bQE7iQkqDl1UloTj/iwJzeOCnBmVYdVjKtUdYQEvgbZsnGY
         eyOWJDBOjoGsE9FPAL1l+YCG9Qt7msF20oYzOYSApRktiz7iEmMbcCfpAXEhe9vFNImi
         ANMsUucmqEADHKg84pI6O4/gdX3v6BQ6/clYpkGzELryR8mkPZxAYp9L9rbBd/t22+9E
         fgZDVwwjLtWvwGXUNFHATgNpgqK7n6GM8rrAO+AKtwsQ+Pou+aOPxTI3Pnh/SEnbaMCt
         Fe8w==
X-Gm-Message-State: AOAM531yfo9m5hKM1uuUr7DeS/rYU4caBQr9Eo8y1oBSdyrKSpWoY4Gc
        cOQkqg+2fZZgUMFj2CpP4fQ9EA==
X-Google-Smtp-Source: ABdhPJxOwI5RHIhqZd5sqTZJ3BeFjY/QwyZ69aihzdHcq4MYx7e3PrGhvAMQ5MYwvG0KK4zLFTqSZQ==
X-Received: by 2002:a63:d66:: with SMTP id 38mr983974pgn.400.1602718304430;
        Wed, 14 Oct 2020 16:31:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r201sm780160pfc.98.2020.10.14.16.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:31:43 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:31:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
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
Message-ID: <202010141611.70B7A38@keescook>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
 <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
 <20201014091720.GC2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014091720.GC2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 11:17:20AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 08:12:20PM -0600, Shuah Khan wrote:
> 
> > They don't add any new behavior, As Kees mentioned they do give us a
> > way to clearly differentiate atomic usages that can wrap.
> 
> No it doesn't! atomic_t can wrap, this thing can wrap, no distinction.
> 
> All it does is fragment the API and sow confusion. FOR NO BENEFIT.

I really don't see it this way. It's a distinct subset of the atomic_t
API. The trouble that has existed here has been with an atomic_t being
originally used NOT for lifetime management, that mutates into something
like that because of the available API, but doing so without realizing
it. atomic_t gets used for all kinds of algorithms, and the "counter"
type is way too easily accidentally transformed into a "lifetime
tracker" and we get bugs.

If we have a distinct type for wrapping-counters that limits the API,
then it is much harder for folks to shoot themselves in the foot. I don't
see why this is so bad: we end up with safer usage, more easily auditable
code behavior ("how was this atomic_t instance _intended_ to be used?"),
and no change in binary size.

> > There is no need to keep inc_return in this API as such. I included it
> > so it can be used for above cases 1 and 2, so the users don't have to
> > call inc() followed by read(). It can be left out of the API.

I go back and forth on this, but after looking at these instances,
it makes sense to have inc_return(), for where counters are actually
"serial numbers". An argument could be made[1], however, that such uses
should not end up in the position of _reusing_ earlier identifiers, which
means it's actually can't wrap. (And some cases just need u64 to make this
happen[2] -- and in that specific case, don't even need to be atomic_t).

[1] https://lore.kernel.org/lkml/202010071334.8298F3FA7@keescook/
[2] https://git.kernel.org/linus/d1e7fd6462ca9fc76650fbe6ca800e35b24267da

> Wrong! The atomic usage in mutex doesn't fall in any of those
> categories.

But the atomic usage in mutex is *IN* mutex -- it's a separate data
type, etc. We don't build mutexes manually, so why build counters
manually?

> The only thing you're all saying that makes sense is that unintentional
> wrapping can have bad consequences, the rest is pure confusion.
> 
> Focus on the non-wrapping cases, _everything_ else is not going
> anywhere.

I view this as a way to do so: this subset of wrapping cases is being
identified and removed from the pool of all the atomic_t cases so that
they will have been classified, and we can continue to narrow down all
the atomic_t uses to find any potentially mis-used non-wrapping cases.

The other option is adding some kind of attribute to the declarations
(which gets us the annotation) but doesn't provide a limit to the API.
(e.g. no counter should ever call dec_return).

> So audit the kernel, find the cases that should not wrap, categorize and
> create APIs for them that trap the wrapping. But don't go around
> confusing things that don't need confusion.

That's what's happening here. But as it turns out, it's easier to do
this by employing both the process of elimination (mark the counters)
and direct identification (mark the refcount_t). Then the pool of
"unannotated" atomic_t instances continues to shrink.

-- 
Kees Cook
