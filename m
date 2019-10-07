Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA33BCDD73
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJGIlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 04:41:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39634 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfJGIlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 04:41:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so7765885pgj.6
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d00h7IdnG9Bs/4S91y4kH9nayVR/gCRtlft74BTzy6I=;
        b=AUmIkwxCvC2VEhvpzdAyuNovVm2KMJDpgDWO5MBAsHUd4584+mQuTJYZeAiA+9d8qf
         Cb8CstcWhfdXgmKTT8Jlla+OWOrkQkY1Q6jQNfjMg0AaTBOEx4pAXKvHC9GWvBLdZn5f
         azsN30/RzedzrQSkqzovoBINho5ERfih75S8sqKoNuhZtu7ZJ6mBbxw52wj46VIAfs+0
         /MI6tTyO9gi1ONrL9pd+19m5cKkMzvosoY+gvlO9IBXyVRyQi1ybU6t67GV8aiwd0d0e
         6C9JtrHHYWmRkyPJoTmdFUFF6AQSVURI2bOhzr9RF9ZKtLjjyBGodHKo0R5D8MzKfjXZ
         yRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d00h7IdnG9Bs/4S91y4kH9nayVR/gCRtlft74BTzy6I=;
        b=lUo1vupW6wRtYVUh0IM71enmzd3JqDnFw7rex/Xef/CXQGeoFV4hhzjat1EaqRAdYc
         vrbimNPqAb2wyahdVhHWl8fI9+fQhNl7GHK7Sndn+Nv8zpmRWP95fcjQhn5EvTYY9sp3
         BIUmY9EElSyYV8K5bsEYUqH20Sh/f1ZaRFV/jLiogcFfttk+GACZio5C4oXDCBA6EslB
         9ICbtDYvtxCzaWxOV9XkCfhicUhgDFt3pgaYkv76WIuBUhbwEtfF0w32L4suv1gkFkUt
         owCOa1cTJAqqaI/n/zngQEv307R8iy1sWbInYOgMLLhyM1z5cpAIjIyv9gBid5RRg//3
         K8RA==
X-Gm-Message-State: APjAAAUnXXifNR2vVN7vv8uEoPkHSDpqHbsFFjcw1fd0NaI9MmaIuSkl
        Kq0C1fnIW92x0d0cw5cZ0K3TtzF1tv0G7wY6wlVvRQ==
X-Google-Smtp-Source: APXvYqwxXGxNWrOtyc6pCGXMSd6S1trXysWwf0BjsGf8IFVQEjIqe/b6qXijaBYnb2AJQF5sarq/ZPYHb1uY+bE9OzQ=
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr32723780pji.131.1570437665358;
 Mon, 07 Oct 2019 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org> <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu> <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
In-Reply-To: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Oct 2019 01:40:53 -0700
Message-ID: <CAFd5g45djTX+FaXwn2abve1+6GbtNrv+8EJgDe_TXn1d+pzukA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, shuah <shuah@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 6, 2019 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Well, one thing we *can* do is if (a) if we can create a kselftest
> > branch which we know is stable and won't change, and (b) we can get
> > assurances that Linus *will* accept that branch during the next merge
> > window, those subsystems which want to use kself test can simply pull
> > it into their tree.
>
> Yes.
>
> At the same time, I don't think it needs to be even that fancy. Even
> if it's not a stable branch that gets shared between different
> developers, it would be good to just have people do a "let's try this"
> throw-away branch to use the kunit functionality and verify that
> "yeah, this is fairly convenient for ext4".
>
> It doesn't have to be merged in that form, but just confirmation that
> the infrastructure is helpful before it gets merged would be good.

I thought we already had done this satisfactorily.

We have one proof-of-concept test in the branch in the kselftest repo
(proc sysctl test) that went out in the pull request, and we also had
some other tests that were not in the pull request (there is the ext4
timestamp stuff mentioned above, and we also had one against the list
data structure), which we were planning on sending out for review once
Shuah's pull request was accepted. I know the apparmor people also
wrote some tests that they said were useful; however, I have not
coordinated with them on upstreaming their tests. I know of some other
people who are using it, but I don't think the tests are as far along
for upstreaming.

The point is: I thought we had plenty of signal that KUnit would be
useful to have merged into the mainline kernel. I thought the only
reason it was rejected for 5.4 was due to the directory name issue
combined with bad timing.

Please correct me if I missed anything.

Thanks!
