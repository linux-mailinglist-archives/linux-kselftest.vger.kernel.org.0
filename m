Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973DC318B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBKM73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 07:59:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:38904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhBKM4N (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 07:56:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613048127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDHyixPZc/hmwJlqM4MC2vKvRBa6s3jBQvaQGvjSoUI=;
        b=F3z/vrIEVhUfZGwqeG2qCI7qxZnhkSJOrLREdCB8mhjpdG2qgKYyEo/nzk/zyCtGBziZ3L
        /LS8n/HXbEMlAfueoiMfHhuvmIwReGag+vKuB4IB5Cxs0Nc55uMLZzYyWww2FjRuL2piMz
        X9XhAl7iTyZD3KcfraFKLVultoWxxi8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D483AAC69;
        Thu, 11 Feb 2021 12:55:26 +0000 (UTC)
Date:   Thu, 11 Feb 2021 13:55:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v5 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YCUpPUDIw7AydY9N@alley>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
 <20210208140154.10964-2-rf@opensource.cirrus.com>
 <YCFWRp8a0sw3mUSI@smile.fi.intel.com>
 <2f9f57a3-f0d6-1e07-36f9-682d65b481ad@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9f57a3-f0d6-1e07-36f9-682d65b481ad@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2021-02-08 17:38:29, Richard Fitzgerald wrote:
> On 08/02/2021 15:18, Andy Shevchenko wrote:
> > On Mon, Feb 08, 2021 at 02:01:52PM +0000, Richard Fitzgerald wrote:
> > > The existing code attempted to handle numbers by doing a strto[u]l(),
> > > ignoring the field width, and then repeatedly dividing to extract the
> > > field out of the full converted value. If the string contains a run of
> > > valid digits longer than will fit in a long or long long, this would
> > > overflow and no amount of dividing can recover the correct value.
> > > 
> > > -unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
> > > +static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
> > > +					   char **endp, unsigned int base)
> > >   {
> > > -	unsigned long long result;
> > > +	const char *cp;
> > > +	unsigned long long result = 0ULL;
> > >   	unsigned int rv;
> > > -	cp = _parse_integer_fixup_radix(cp, &base);
> > > -	rv = _parse_integer(cp, base, &result);
> > > +	cp = _parse_integer_fixup_radix(startp, &base);
> > > +	if ((cp - startp) >= max_chars) {
> > > +		cp = startp + max_chars;
> > > +		goto out;
> > > +	}
> > > +
> > > +	max_chars -= (cp - startp);
> > > +	rv = _parse_integer_limit(cp, base, &result, max_chars);
> > >   	/* FIXME */
> > >   	cp += (rv & ~KSTRTOX_OVERFLOW);
> > > +out:
> > >   	if (endp)
> > >   		*endp = (char *)cp;
> > >   	return result;
> > >   }
> > 
> > A nit-pick: What if we rewrite above as
> > 
> > static unsigned long long simple_strntoull(const char *cp, size_t max_chars,
> > 					   char **endp, unsigned int base)
> > {
> > 	unsigned long long result = 0ULL;
> > 	const char *startp = cp;
> > 	unsigned int rv;
> > 	size_t chars;
> > 
> > 	cp = _parse_integer_fixup_radix(cp, &base);
> > 	chars = cp - startp;
> > 	if (chars >= max_chars) {
> > 		/* We hit the limit */
> > 		cp = startp + max_chars;
> > 	} else {
> > 		rv = _parse_integer_limit(cp, base, &result, max_chars - chars);
> > 		/* FIXME */
> > 		cp += (rv & ~KSTRTOX_OVERFLOW);
> > 	}
> > 
> > 	if (endp)
> > 		*endp = (char *)cp;
> > 
> > 	return result;
> > }
> > 
> > ...
> 
> 
> I don't mind rewriting that code if you prefer that way.
> I am used to working on other kernel subsytems where the preference is
> to bail out on the error case so that the "normal" case flows without
> nesting.

Yeah. But in this case Andy's variant looks slightly better redable to me.

...

> > 
> > > +			val.s = simple_strntoll(str,
> > > +						field_width > 0 ? field_width : SIZE_MAX,
> > > +						&next, base);
> > 
> > A nit-pick: Wouldn't be negative field_width "big enough" to just being used as

 
> field_width is s16 so really should be sign-extended

I guess that Andy just missed that it was a signed type. And it has to be
because  -1 means SIZE_MAX.

> to make it "very
> big". I think this would be less readable what the intention is and what
> assumptions it is based on. There's a risk someone would look at
> 
> (size_t)(long)field_width
> 
> and think the (long) is redundant.
> Perhaps change field_width to int? There I ask myself "if it can be an
> int, why is it declared s16?" and worry there is something subtle in the
> code.
> 
> My personal preference is to avoid using tricks in code that isn't time
> critical.

I agree. Let's keep the check with signed type.

> > is? Also, is field_width == 0 should be treated as "parse to the MAX"?

filed_width == 0 actually means that no characters are read. I should
return zero value.

> > ...
> 
> Earlier code terminates scanning if the width parsed from the format
> string is <= 0.

To make it clear what earlier code means. vsscanf() bail out earlier
when field_width == 0. It is handled by this code:

		/* get field width */
		field_width = -1;
		if (isdigit(*fmt)) {
			field_width = skip_atoi(&fmt);
			if (field_width <= 0)
				break;
		}

> So field_width can only be -1 or > 0 here. But now you
> point it out, that test would be better as field_width >= 0 ... so
> it deals with 0 if it ever happened to sneak through to here
> somehow.

It might make sense to be proactive and change it to >= 0.
But I would do it in a separate patch. The "< 0" condition
matches the original code.

Best Regards,
Petr
