Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C768430F81C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhBDQgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 11:36:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237152AbhBDQgM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 11:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612456515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUjLyiqQ4utGC6qodHBCUygl1CqqAiXa12iI219baz4=;
        b=BNQK06tY3c6oPYMlrJUmoOwDwyyuPLcT9wQsvkuONAATKRqnR6IKOx+plLp6ZPu7Tjh+oM
        2GiRxiAGJIETGsPK6Ffz+bkfC6h3+8wavXQt32yxXI/Mr8HjGkyCyPuy3TP58vz2svmjp0
        dG61c+c0ct2JNcbGNyyZLJRbiQMCBEI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6C29AD87;
        Thu,  4 Feb 2021 16:35:15 +0000 (UTC)
Date:   Thu, 4 Feb 2021 17:35:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YBwiQ+l6yqs+g+rr@alley>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com>
 <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2021-02-03 21:45:55, Andy Shevchenko wrote:
> On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:
> > The existing code attempted to handle numbers by doing a strto[u]l(),
> > ignoring the field width, and then repeatedly dividing to extract the
> > field out of the full converted value. If the string contains a run of
> > valid digits longer than will fit in a long or long long, this would
> > overflow and no amount of dividing can recover the correct value.

> ...
> 
> > +	for (; max_chars > 0; max_chars--) {
> 
> Less fragile is to write
> 
> 	while (max_chars--)

Except that the original was more obvious at least for me.
I always prefer more readable code when the compiler might do
the optimization easily. But this is my personal taste.
I am fine with both variants.

> 
> This allows max_char to be an unsigned type.
> 
> Moreover...
> 
> > +	return _parse_integer_limit(s, base, p, INT_MAX);
> 
> You have inconsistency with INT_MAX vs, size_t above.

Ah, this was on my request. INT_MAX is already used on many other
locations in vsnprintf() for this purpose.

An alternative is to fix all the other locations. We would need to
check if it is really safe. Well, I do not want to force Richard
to fix this historical mess. He already put a lot lot of effort
into fixing this long term issue.

...

> > -	unsigned long long result;
> > +	const char *cp;
> > +	unsigned long long result = 0ULL;
> >  	unsigned int rv;
> >  
> > -	cp = _parse_integer_fixup_radix(cp, &base);
> > -	rv = _parse_integer(cp, base, &result);
> 
> > +	if (max_chars == 0) {
> > +		cp = startp;
> > +		goto out;
> > +	}
> 
> It's redundant if I'm not mistaken.

Also this is more obvious and less error prone from my POV.
But I agree that it is redundant. I am not sure if this
function is used in some fast paths.

Again I am fine with both variants.

> > +	cp = _parse_integer_fixup_radix(startp, &base);
> > +	if ((cp - startp) >= max_chars) {
> > +		cp = startp + max_chars;
> > +		goto out;
> > +	}
> 
> This will be exactly the same, no?

Best Regards,
Petr
