Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768359F52B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfH0VhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 17:37:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbfH0VhB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 17:37:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so193260pgv.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kMi4zPMHWacIIVvEpsVNB2uVTvahLBPSKnQM5VXg1g=;
        b=FzLF1znK+sBBhtGiNLs3csbTpIeQU1SFpy5FX1E/04MwzlJu/0ZnNX95GT+lXi7UBz
         zgN3APVzjb/03MwWFeLzh3i/89YQq9IqkoacAQAHW5EIku1cKLwHkcx4HL4lkOvKporl
         MqnddmYmWohTdLV0m6DXGZkUFiTRlkwV10yHHajuYPoperS+VvLU5EYrxY32ot/G8YNN
         Mr/70wTbXQjVPynmmlkGtV9qwY1dr/LwJ7kq5iPIi2of+ZGeZ9+Pjqr6yfkN+Kaf4W2H
         9XcNanMdK2BSNCQfEpFMhUZ9HzcL7nafSdnH6BU7EY+T3SSEm2VgZLD1eCI1AP6XBbJi
         TUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kMi4zPMHWacIIVvEpsVNB2uVTvahLBPSKnQM5VXg1g=;
        b=gt9cvDiy+0uAMjgfoKk0pZvs2naw8VPk9dT7Pv8lwEt2NN/7El6U3teI5622mb/ltK
         vx4mBRr99E7Ws45t/pznk2h5MBtuG5HEjntahipVh3gh9Lruo3UnXKbOxbJzcayVlgV/
         JclDC9754DjyfUMLhfwTY+K0Jvh1PmAeA8t2WeSTbalpeKDDcw1go38fAJHZl/1bUtur
         On1RJiSRJ61p/9s6QO3GjVvkyqABJxgyZOW7dXw5C1pPzKHXdFtEk7rlq7debsGB54l7
         XhguCewrgkrIww4Y3ZcGko3RCuWwY/Z1tzLaXefbvZWitX3Mk/PY2rYpi9kO7IVWKBXK
         9zWA==
X-Gm-Message-State: APjAAAX+4a0UsU6aF55Rk/GYJq/orVrEg7o9WWs7DF/ePitWvOhwEM3r
        tZ0Y44hIQgAymmsOk6zhMuV2pBRy3XlTXM+Rbr4oyQ==
X-Google-Smtp-Source: APXvYqygR6QsgO+h2AnQoLbAAFRFzalFDLqkKsy4+Dyn2xUfmrn7ceUN77WNJK2y0altaH/XBmGYKqdEW9PU8xDCKXA=
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr691594pfr.113.1566941820480;
 Tue, 27 Aug 2019 14:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org> <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
 <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
In-Reply-To: <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 14:36:49 -0700
Message-ID: <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     shuah <shuah@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 27, 2019 at 2:09 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
> > >
> > > On 8/27/19 11:49 AM, Brendan Higgins wrote:
> > > > Previously KUnit assumed that printk would always be present, which is
> > > > not a valid assumption to make. Fix that by ifdefing out functions which
> > > > directly depend on printk core functions similar to what dev_printk
> > > > does.
> > > >
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > ---
> > > >   include/kunit/test.h |  7 +++++++
> > > >   kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
> > > >   2 files changed, 31 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index 8b7eb03d4971..339af5f95c4a 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> > [...]
> > > Okay after reviewing this, I am not sure why you need to do all
> > > this.
> > >
> > > Why can't you just change the root function that throws the warn:
> > >
> > >   static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > > {
> > >          return vprintk_emit(0, level, NULL, 0, fmt, args);
> > > }
> > >
> > > You aren'r really doing anything extra here, other than calling
> > > vprintk_emit()
> >
> > Yeah, I did that a while ago. I think it was a combination of trying
> > to avoid an extra layer of adding and then removing the log level, and
> > that's what dev_printk and friends did.
> >
> > But I think you are probably right. It's a lot of maintenance overhead
> > to get rid of that. Probably best to just use what the printk people
> > have.
> >
> > > Unless I am missing something, can't you solve this problem by including
> > > printk.h and let it handle the !CONFIG_PRINTK case?
> >
> > Randy, I hope you don't mind, but I am going to ask you to re-ack my
> > next revision since it basically addresses the problem in a totally
> > different way.
>
> Actually, scratch that. Checkpatch doesn't like me calling printk
> without using a KERN_<LEVEL>.
>
> Now that I am thinking back to when I wrote this. I think it also
> might not like using a dynamic KERN_<LEVEL> either (printk("%s my
> message", KERN_INFO)).
>
> I am going to have to do some more investigation.

Alright, I am pretty sure it is safe to do printk("%smessage", KERN_<LEVEL>);

Looking at the printk implementation, it appears to do the format
before it checks the log level:

https://elixir.bootlin.com/linux/v5.2.10/source/kernel/printk/printk.c#L1907

So I am pretty sure we can do it either with the vprintk_emit or with printk.

So it appears that we have to weigh the following trade-offs:

Using vprintk_emit:

Pros:
 - That's what dev_printk uses.
 - No checkpatch warnings.

Cons:
 - Harder to maintain (requires ifdefery).

Using printk:

Pros:
 - Easier to maintain.

Cons:
 - I am less confident that it is correct (I am not 100% certain that
printk is intended to be used this way).
 - Checkpatch warnings.
 - Extra layer of string formatting.

My preference is to go the vprintk_emit route since I am more
confident that it is right, but I don't have a strong preference.
