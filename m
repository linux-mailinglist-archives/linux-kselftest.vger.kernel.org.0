Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63A318C29
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBKNfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 08:35:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhBKNd2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 08:33:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613050356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8QpkuKwFOuoCzlSfpkMbEMntQ0JgQj2Ria9Y2eQ5X4=;
        b=LNu5rrw/53bJBbVAvw9MTl65Q2KhDVUcipbrntqj+KxZbKwvSy1VrZowz5Tn+RCX5BjTah
        K1QT8BCTqBJhwkmRA2cmlHvj4KRA7kX+rTwZbeQZNoWMkd46v0ijSN46tG6dbhqgqGKTTQ
        qsAeiLK6oWkEJxpLba0jum/KQRCJLuc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2529AF31;
        Thu, 11 Feb 2021 13:32:36 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:32:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v5 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YCUx9EqdV4ZOXqyI@alley>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
 <20210208140154.10964-2-rf@opensource.cirrus.com>
 <YCFWRp8a0sw3mUSI@smile.fi.intel.com>
 <2f9f57a3-f0d6-1e07-36f9-682d65b481ad@opensource.cirrus.com>
 <YCUpPUDIw7AydY9N@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUpPUDIw7AydY9N@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2021-02-11 13:55:26, Petr Mladek wrote:
> On Mon 2021-02-08 17:38:29, Richard Fitzgerald wrote:
> > On 08/02/2021 15:18, Andy Shevchenko wrote:
> > > On Mon, Feb 08, 2021 at 02:01:52PM +0000, Richard Fitzgerald wrote:
> > > A nit-pick: What if we rewrite above as
> > > 
> > > static unsigned long long simple_strntoull(const char *cp, size_t max_chars,
> > > 					   char **endp, unsigned int base)
> > > {
> > > 	unsigned long long result = 0ULL;
> > > 	const char *startp = cp;
> > > 	unsigned int rv;
> > > 	size_t chars;
> > > 
> > > 	cp = _parse_integer_fixup_radix(cp, &base);
> > > 	chars = cp - startp;
> > > 	if (chars >= max_chars) {
> > > 		/* We hit the limit */
> > > 		cp = startp + max_chars;
> > > 	} else {
> > > 		rv = _parse_integer_limit(cp, base, &result, max_chars - chars);
> > > 		/* FIXME */
> > > 		cp += (rv & ~KSTRTOX_OVERFLOW);
> > > 	}
> > > 
> > > 	if (endp)
> > > 		*endp = (char *)cp;
> > > 
> > > 	return result;
> > > }
> > > 
> > > ...
> > 
> > 
> > I don't mind rewriting that code if you prefer that way.
> > I am used to working on other kernel subsytems where the preference is
> > to bail out on the error case so that the "normal" case flows without
> > nesting.
> 
> Yeah. But in this case Andy's variant looks slightly better redable to me.


> ...
> 
> > > 
> > > > +			val.s = simple_strntoll(str,
> > > > +						field_width > 0 ? field_width : SIZE_MAX,
> > > > +						&next, base);
> > > 
> > > is? Also, is field_width == 0 should be treated as "parse to the MAX"?
> > 
> > Earlier code terminates scanning if the width parsed from the format
> > string is <= 0.
> 
> > So field_width can only be -1 or > 0 here. But now you
> > point it out, that test would be better as field_width >= 0 ... so
> > it deals with 0 if it ever happened to sneak through to here
> > somehow.
> 
> It might make sense to be proactive and change it to >= 0.
> But I would do it in a separate patch. The "< 0" condition
> matches the original code.

Ah, I have missed that you have already sent v6 where you did this change
in the same patch. There is no need to resend it just because of this.
I am going to look at v6.

Best Regards,
Petr
