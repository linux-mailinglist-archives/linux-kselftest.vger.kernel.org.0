Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69046A40BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfH3XC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:02:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38197 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfH3XC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:02:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so4019032plp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2019 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuSrKaBjz6ivWHwLFrJgF/L58VeUxzznRdGEYR+c17w=;
        b=EYxkV44gAiJ5RGYNjhQk6VbArVubnJW/4qj50Eu8EsglB+MFzheaW/0YM4soCMmUvy
         sBx6BCsU81MbaWrb+zExxv/sNrAWyhxZbGpG5nDfEGZ4nUDjLCxBqp+6G+LL+525lhlN
         HbokrROYgvVX1dBiCYW/M7kPYIrtL3VeLSKEN4SqEtlcOFqwEs2sTM4RIaUsHpqPOtJF
         ChT3acb5jJ3MDHbDXseFCZs8DkuC/cUStBiX5q3gu8fByUeNedQvJ0kytpmpRvGmxM23
         mS3rHmTMIrL5iw5YAcFJDl6gOqJXnQ/WFaH0Nxyky0M5SYDCrBTjbkI+Y02q3Ihi/x7d
         rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuSrKaBjz6ivWHwLFrJgF/L58VeUxzznRdGEYR+c17w=;
        b=LLzaK0ViBMEudpmU0ErEqgtQvHnmAb6I3MXhHIPCso7irfK0Afq7z9qLIh6G/C3mN4
         oFxbJN15VNv8w0qkeMGr1nHeioBpPD3JUlZrbo41OoFL7zJduHCKinj3PfsBeR+etxE4
         VYB/lHVWcmhYTJTVL3xOhrIroB1yN9wRI93ocLSTuso+srT48QRTuNsiZCvGxnvaPxhA
         JjLyH/iQjPZ14k1DROBE1jOmcfo2RKDqthfuAx0DlL0mm0b8PNU0Mfg0YuVCFFtXEDBr
         KpjrTI0xTYG0vZJI+hQIf4+qtrsiGIUJqNhomT9+ycy/wWX07ifMX+WTAxXFf2R59PNt
         l7Jg==
X-Gm-Message-State: APjAAAV8Um0fTV9vko6y+CtKt3ITMo6miyqQGOoO87LTwhwianOGgpS/
        ZnuGTE+gNB9oQUEIy4QjINLX1FUlBP/nFeIDzc5wSw==
X-Google-Smtp-Source: APXvYqzkMlSCoOQPf0lhYF0++cQJXd6u59DjiL0h5Bj++9ubODi8+C2cl9McsvOTctf9UxMtNw30sqoEUw3WN7OcBu0=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr17348451plb.297.1567206144995;
 Fri, 30 Aug 2019 16:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV> <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
 <20190830183821.GA30306@google.com> <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com> <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
In-Reply-To: <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 30 Aug 2019 16:02:13 -0700
Message-ID: <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
To:     Joe Perches <joe@perches.com>
Cc:     "Bird, Timothy" <Tim.Bird@sony.com>, shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Petr Mladek <pmladek@suse.com>, sergey.senozhatsky@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 3:46 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > > From: Joe Perches
> []
> > IMHO %pV should be avoided if possible.  Just because people are
> > doing it doesn't mean it should be used when it is not necessary.
>
> Well, as the guy that created %pV, I of course
> have a different opinion.
>
> > >  then wouldn't it be easier to pass in the
> > > > kernel level as a separate parameter and then strip off all printk
> > > > headers like this:
> > >
> > > Depends on whether or not you care for overall
> > > object size.  Consolidated formats with the
> > > embedded KERN_<LEVEL> like suggested are smaller
> > > overall object size.
> >
> > This is an argument I can agree with.  I'm generally in favor of
> > things that lessen kernel size creep. :-)
>
> As am I.

Sorry, to be clear, we are talking about the object size penalty due
to adding a single parameter to a function. Is that right?
