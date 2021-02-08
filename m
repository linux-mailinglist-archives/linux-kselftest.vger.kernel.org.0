Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120C313BE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBHR6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 12:58:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:46648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhBHR45 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 12:56:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612806968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qwX5AXIbxXOiec6IOEaZx2uQnDbXmhCzt+dVXpbysvA=;
        b=EVBIKarOePQu94XVdxLXJJnkOl+DUYKHHxFANZoOe6CB21HFXP9fzT1oUvfNWTXYUiVqZ8
        2DQlyXuxgB+ZdmH25poZbJG3fgAhqVaLFM/nE8rQ+9/bO68q7WNuKXqn2yUt9SA/N1l8e1
        9Yu9/8qOFvUEcTlIJO8LscB/o0bLMV0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29846AD62;
        Mon,  8 Feb 2021 17:56:08 +0000 (UTC)
Date:   Mon, 8 Feb 2021 18:56:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YCF7N0Fc9WC9flyd@alley>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com>
 <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
 <YBwiQ+l6yqs+g+rr@alley>
 <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
 <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2021-02-05 14:50:56, Andy Shevchenko wrote:
> On Fri, Feb 5, 2021 at 1:35 PM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> > On 04/02/2021 16:35, Petr Mladek wrote:
> > > On Wed 2021-02-03 21:45:55, Andy Shevchenko wrote:
> > >> On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:
> > >> This allows max_char to be an unsigned type.
> > >>
> > >> Moreover...
> > >>
> > >>> +   return _parse_integer_limit(s, base, p, INT_MAX);
> > >>
> > >> You have inconsistency with INT_MAX vs, size_t above.
> > >
> > > Ah, this was on my request. INT_MAX is already used on many other
> > > locations in vsnprintf() for this purpose.
> >
> > I originally had UINT_MAX and changed on Petr's request to be
> > consistent with other code. (Sorry Andy - my mistake not including
> > you on the earlier review versions).
> >
> > But 0 < INT_MAX < UINT_MAX, so ok to pass to an unsigned. And as Petr
> > said on his original review, INT_MAX is "big enough".
> 
> Some code has INT_MAX, some has UINT_MAX, while the parameter is size_t.

Yeah, if I remember correctly I wanted to have INT_MAX everywhere but
I did not want to nitpick about it in the later versions. It looked
like an arbitrary number anyway.

> I think all of these inconsistencies should have a comment either in
> the code, or in the commit message, or in the cover letter (depending
> on the importance).
> Or being fixed to be more consistent with existing code. Whichever you
> consider better.

OK, you made me to do some archaeology. The INT_MAX limit has
been added into vsnprintf() in 2.6.2 by the commit:

Author: Linus Torvalds <torvalds@home.osdl.org>
Date:   Mon Feb 2 21:17:29 2004 -0800

    Warn loudly if somebody passes a negative value as
    the size to "vsnprintf()".

    That's a pretty clear case of overflow.


It might catch problems. And the limit seems to have worked all the time.

IMHO, it would make sense to have INT_MAX limit also in
_parse_integer_limit() and WARN() when a larger value is passed.

By other words, it would mean to add this check and use INT_MAX
everywhere in this patch.

Best Regards,
Petr
