Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DDA4118
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfH3XhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:37:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41372 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfH3XhR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:37:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so4266011pgg.8
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2019 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFTK9l48HgFlEfO2ql+ojPVP+yldR+Yv79LTZZYwKgY=;
        b=soGYPU2cXZVyEmSQrFtuZNhQ1j3VNFQJMN2wp6q10eDbyQfq8hQxHBrRL9izb5VZc7
         eXz9edafaF8M5TP3yZDWnF/EopxRz3g049UVV70/TcDbaTn7hb/UPjz/+MZfQytEb1uZ
         6fZJdK0Tb23JLwQfd75dCGUeOSFrXwTJHGoIhgOQTqk7qBps4c97F1zxF3bzcd3C4P4S
         W7a9gItWvAaWjNjTvYc4CAgY5SzR76Vbl4xd6NMvw2s709Vt5MwB+9P2bntXaec82+2j
         FeBKCuzpLjxYNBLJfz65j7bebXt50JjCPXpXHC3sbb0BehhwQwo1wN2hTsTsr9+cg+5l
         NyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFTK9l48HgFlEfO2ql+ojPVP+yldR+Yv79LTZZYwKgY=;
        b=qhV9VJA2yV57EnMhJ41vzgk5ln0XW7ev2UGaQHw26+qxJeDhyGK/c0CqpW/f5pTtLD
         NiF2NL9y4AqIi+xLkO1rWQrULY0bul6wcMdNqRkB4FYV2RUTNi/pWjJWZaRQKJM+wxUH
         7tMWfOTSk6UgXsbM3GNXZlu5Gx2eZMLy55CC4EIEHMf1GCOKkHenl01lH5wKmkwV7g11
         ydcYtLGjYIQuzYvpxl95DggR2J1x5QhtzSiH41t8QjuJ6dQ+yGh6Lf9RX9Vfzkj1ReIL
         ST1motIgjnG3BIk7vEF6wpRvkIUH1cKMnAYBZu/vIwUMg1fueD1NsxdNd6NRlqpOWYK3
         GjvQ==
X-Gm-Message-State: APjAAAXJpljWdfKfu4Rg4/8tejhSQcNb+L+fpg2/mpnrMdgTeW95I0Cy
        QhGMdwXerVJZzUDFLFui8ltAgQ==
X-Google-Smtp-Source: APXvYqw6w0Q4kDWY2duwjPimT9htv/UJFgKQCmcAUtnMSA/hgFu1PLvccl2u2lz0C3vbaaQrSHrzOg==
X-Received: by 2002:a63:d002:: with SMTP id z2mr15369704pgf.364.1567208236014;
        Fri, 30 Aug 2019 16:37:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id x22sm14444793pfo.180.2019.08.30.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:37:15 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:37:10 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Tim.Bird@sony.com
Cc:     joe@perches.com, shuah@kernel.org,
        sergey.senozhatsky.work@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        rdunlap@infradead.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
Message-ID: <20190830233710.GA101591@google.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
 <20190830183821.GA30306@google.com>
 <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
 <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
 <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 11:22:43PM +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Brendan Higgins 
> > 
> > On Fri, Aug 30, 2019 at 3:46 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > > > > From: Joe Perches
> > > []
> > > > IMHO %pV should be avoided if possible.  Just because people are
> > > > doing it doesn't mean it should be used when it is not necessary.
> > >
> > > Well, as the guy that created %pV, I of course
> > > have a different opinion.
> > >
> > > > >  then wouldn't it be easier to pass in the
> > > > > > kernel level as a separate parameter and then strip off all printk
> > > > > > headers like this:
> > > > >
> > > > > Depends on whether or not you care for overall
> > > > > object size.  Consolidated formats with the
> > > > > embedded KERN_<LEVEL> like suggested are smaller
> > > > > overall object size.
> > > >
> > > > This is an argument I can agree with.  I'm generally in favor of
> > > > things that lessen kernel size creep. :-)
> > >
> > > As am I.
> > 
> > Sorry, to be clear, we are talking about the object size penalty due
> > to adding a single parameter to a function. Is that right?
> 
> Not exactly.  The argument is that pre-pending the different KERN_LEVEL
> strings onto format strings can result in several versions of nearly identical strings
> being compiled into the object file.  By parameterizing this (that is, adding
> '%s' into the format string, and putting the level into the string as an argument),
> it prevents this duplication of format strings.
> 
> I haven't seen the data on duplication of format strings, and how much this
> affects it, but little things can add up.  Whether it matters in this case depends
> on whether the format strings that kunit uses are also used elsewhere in the kernel,
> and whether these same format strings are used with multiple kernel message levels.
>  -- Tim

I thought this portion of the discussion was about whether Joe's version
of kunit_printk was better or my critique of his version of kunit_printk:

Joe's:
> > > > -void kunit_printk(const char *level,
> > > > -		  const struct kunit *test,
> > > > -		  const char *fmt, ...)
> > > > +void kunit_printk(const struct kunit *test, const char *fmt, ...)
> > > >  {
> > > > +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
> > > >  	struct va_format vaf;
> > > >  	va_list args;
> > > > +	int kern_level;
> > > >
> > > >  	va_start(args, fmt);
> > > >
> > > > +	while ((kern_level = printk_get_level(fmt)) != 0) {
> > > > +		size_t size = printk_skip_level(fmt) - fmt;
> > > > +
> > > > +		if (kern_level >= '0' && kern_level <= '7') {
> > > > +			memcpy(lvl, fmt,  size);
> > > > +			lvl[size] = '\0';
> > > > +		}
> > > > +		fmt += size;
> > > > +	}
> > > > +
> > > >  	vaf.fmt = fmt;
> > > >  	vaf.va = &args;
> > > >
> > > > -	kunit_vprintk(test, level, &vaf);
> > > > +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
> > > >
> > > >  	va_end(args);
> > > >  }

Mine:
>  void kunit_printk(const char *level,
>  		  const struct kunit *test,
>  		  const char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> 
>  	va_start(args, fmt);
> 
> +	fmt = printk_skip_headers(fmt);
> +
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> 
> -	kunit_vprintk(test, level, &vaf);
> +	printk("%s\t# %s %pV\n", level, test->name, &vaf);
> 
>  	va_end(args);
>  }

I thought you and Joe were arguing that "Joe's" resulted in a smaller
object size than "Mine" (not to be confused with the actual patch I
presented here, which is what Sergey suggested I do on a different
thread).

I really don't feel strongly about what Sergey suggested I do (which is
what this patch originally introduced), versus, what Joe suggested,
versus what I suggested in response to Joe (or any of the things
suggested on other threads). I just want to pick one, fix the breakage
in linux-next, and move on with my life.

Cheers
