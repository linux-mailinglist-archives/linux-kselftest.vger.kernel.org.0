Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 639317E2DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2019 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfHATAK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Aug 2019 15:00:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbfHATAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Aug 2019 15:00:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so34563665pfe.11
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2019 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDxLBS4nbidlZaAtXYw0USt8/H/W+WG8684PWx5rwyQ=;
        b=pv0bAx16eo2h6cETtsAYgENWK9M2bYvG+2Hz6A34FYrqmcynxgrW9FNs/525MND6gB
         2g6kcjb+Wkd+pb0xI7ftHNd0BVOITtTiTdD56/FcKgN4Oo2+porzmf4U9X3Pqjv9ogM1
         Z/kC+frcls4vFOv0a+Igy+yBfGaArcosyMDHDXjiNXpDaeofzOG5DOQcNazFjnvoRzuL
         lMNAJ094wDYyEwWeRaNCuSip3QYCnNDMNHTTayzSCRSrzP0/lO3z9AfO8vlHbyMc08h0
         L6e7CWilIk4y/ObfnP2JjpR9VQdXeLa/Y/zr+BG5epVgFfah7DysLVeveUDkPYm8KXFn
         gqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDxLBS4nbidlZaAtXYw0USt8/H/W+WG8684PWx5rwyQ=;
        b=q5OPWHT6OCfkLuxd/LMQ0QOrSsntyxXnAbm2brSlo3rgf7A2A66lwOUCtgbTxU6e8z
         r3nS4mNA7+LaE+ZMd7MwEaOygpBFuxURCDwV2DsOQX+fVsl5b0GuKLW6cUVVJuFXNH9O
         z3g24gtnGfOCmgb54ouZ1W/jTULB9Ocas9dpAOzjQs8VefhEys96+uE7hXPeyPAxFJ9r
         J3k+xr58tQZzRLrN4N+lznMl9KKKHxTOmguG8V8nV9+8oP0+ODb47/G8D54eUBeyyY7Q
         zDSWgPA03g59WEpRp4blfpj38Br1AbC5keihN/RmZepvxRkHwuzOG1TvfuZAr9C15Y1H
         e7LQ==
X-Gm-Message-State: APjAAAVgHpC6TAAoOtYfdN4m+XSUjniikjKVgOpHQnHUkfasxma0qWpo
        Kndf/OL44HBzxizCKzf8OHVd/sS0llrVR92FkO66MA==
X-Google-Smtp-Source: APXvYqwv+GK8Cv38wHfxPLEhDVQmFebg2D/gxuBYSy86PyxeYJ6WQOVIPvsR1azS2zoUo23aYbsoJojKwt0bn5jaZnM=
X-Received: by 2002:a17:90a:ab0d:: with SMTP id m13mr268291pjq.84.1564686008520;
 Thu, 01 Aug 2019 12:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
 <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org> <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
 <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz> <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
In-Reply-To: <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 1 Aug 2019 11:59:57 -0700
Message-ID: <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, Jeff Dike <jdike@addtoit.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amir Goldstein <amir73il@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@google.com>,
        David Rientjes <rientjes@google.com>,
        kunit-dev@googlegroups.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        wfg@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        John Ogness <john.ogness@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 1, 2019 at 11:55 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2019-07-25 13:21:12, Brendan Higgins wrote:
> > > On Wed, Jul 24, 2019 at 12:31 AM Petr Mladek <pmladek@suse.com> wrote:
> > > >
> > > > On Mon 2019-07-22 16:54:10, Stephen Boyd wrote:
> > > > > Quoting Brendan Higgins (2019-07-22 15:30:49)
> > > > > > On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > What's the calling context of the assertions and expectations? I still
> > > > > > > don't like the fact that string stream needs to allocate buffers and
> > > > > > > throw them into a list somewhere because the calling context matters
> > > > > > > there.
> > > > > >
> > > > > > The calling context is the same as before, which is anywhere.
> > > > >
> > > > > Ok. That's concerning then.
> > > > >
> > > > > >
> > > > > > > I'd prefer we just wrote directly to the console/log via printk
> > > > > > > instead. That way things are simple because we use the existing
> > > > > > > buffering path of printk, but maybe there's some benefit to the string
> > > > > > > stream that I don't see? Right now it looks like it builds a string and
> > > > > > > then dumps it to printk so I'm sort of lost what the benefit is over
> > > > > > > just writing directly with printk.
> > > > > >
> > > > > > It's just buffering it so the whole string gets printed uninterrupted.
> > > > > > If we were to print out piecemeal to printk, couldn't we have another
> > > > > > call to printk come in causing it to garble the KUnit message we are
> > > > > > in the middle of printing?
> > > > >
> > > > > Yes, printing piecemeal by calling printk many times could lead to
> > > > > interleaving of messages if something else comes in such as an interrupt
> > > > > printing something. Printk has some support to hold "records" but I'm
> > > > > not sure how that would work here because KERN_CONT talks about only
> > > > > being used early on in boot code. I haven't looked at printk in detail
> > > > > though so maybe I'm all wrong and KERN_CONT just works?
> > > >
> > > > KERN_CONT does not guarantee that the message will get printed
> > > > together. The pieces get interleaved with messages printed in
> > > > parallel.
> > > >
> > > > Note that KERN_CONT was originally really meant to be used only during
> > > > boot. It was later used more widely and ended in the best effort category.
> > > >
> > > > There were several attempts to make it more reliable. But it was
> > > > always either too complicated or error prone or both.
> > > >
> > > > You need to use your own buffering if you rely want perfect output.
> > > > The question is if it is really worth the complexity. Also note that
> > > > any buffering reduces the chance that the messages will reach
> > > > the console.
> > >
> > > Seems like that settles it then. Thanks!
> > >
> > > > BTW: There is a work in progress on a lockless printk ring buffer.
> > > > It will make printk() more secure regarding deadlocks. But it might
> > > > make transparent handling of continuous lines even more tricky.
> > > >
> > > > I guess that local buffering, before calling printk(), will be
> > > > even more important then. Well, it might really force us to create
> > > > an API for it.
> > >
> > > Cool! Can you CC me on that discussion?
> >
> > Adding John Oggness into CC.
> >
> > John, please CC Brendan Higgins on the patchsets eventually switching
> > printk() into the lockless buffer. The test framework is going to
> > do its own buffering to keep the related messages together.
> >
> > The lockless ringbuffer might make handling of related (partial)
> > lines worse or better. It might justify KUnit's extra buffering
> > or it might allow to get rid of it.
>
> Thanks for CC'ing me on the printk ringbuffer thread. It looks like it
> actually probably won't affect my needs for KUnit logging. The biggest
> reason I need some sort of buffering system is to be able to compose
> messages piece meal into a single message that will be printed out to
> the user as a single message with no messages from other printk
> callers printed out in the middle of mine.
>
> The prb does look interesting; however, it appears that to get the
> semantics that I need, I would have to put my entire message in a
> single data block and would consequently need to know the size of my
> message a priori, which is problematic. Consequently, it seems as
> though I will probably need to compose my entire message using my own
> buffering system.
>
> > > > Note that stroring the messages into the printk log is basically safe in any
> > > > context. It uses temporary per-CPU buffers for recursive messages and
> > > > in NMI. The only problem is panic() when some CPU gets stuck with the
> > > > lock taken. This will get solved by the lockless ringbuffer. Also
> > > > the temporary buffers will not be necessary any longer.
> > >
> > > Sure, I think Stephen's concern is all the supporting code that is
> > > involved. Not printk specifically. It just means a lot more of KUnit
> > > has to be IRQ safe.
> >
> > I see.
> >
> > BTW: I wonder if KUnit could reuse the existing seq_buf implementation
> > for buffering messages.
> >
> > I am sorry if it has already been proposed and rejected for some
> > reason. I might have missed it. Feel free to just point me to
> > same older mail.
>
> Yeah, we discussed it briefly here:
>
> https://lkml.org/lkml/2019/5/17/497
>
> Looks like I forgot to include my reasoning in the commit text, sorry
> about that.
>
> > > > Much bigger problems are with consoles. There are many of them. It
> > > > means a lot of code and more locks involved, including scheduler
> > > > locks. Note that console lock is a semaphore.
> > >
> > > That shouldn't affect us though, right? As long as we continue to use
> > > the printk interface?
> >
> > I guess that it should not affect KUnit.
> >
> > The only problem might be if the testing framework calls printk()
> > inside scheduler or console code. And only when the tested code
> > uses the same locks that will be used by the called printk().
>
> Yeah, well printk will not be our only problem in those instances.
>
> > To be honest I do not fully understand KUnit design. I am not
> > completely sure how the tested code is isolated from the running
> > system. Namely, I do not know if the tested code shares
> > the same locks with the system running the test.
>
> No worries, I don't expect printk to be the hang up in those cases. It
> sounds like KUnit has a long way to evolve before printk is going to
> be a limitation.

So Stephen, what do you think?

Do you want me to go forward with the new kunit_assert API wrapping
the string_stream as I have it now? Would you prefer to punt this to a
later patch? Or would you prefer something else?

Cheers
