Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1711712361
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 22:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEBUaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 16:30:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38664 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBUaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 16:30:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so3361886otp.5
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDdiyphkogtVcXTbSVRyR+FjzQZde+G185126UMJh7I=;
        b=gITVrJC9deQ8wHwXinOhDV5dI98+XHC/WuqFuL8GH7a8CRP7Weez43rOFpDLFNlC0p
         SurYDhddnsqnL5Ihvys33lK/4j+PLxs8IphZcAQuHXXE7X5COStC3ZBhj/5h/Hdg9FPW
         sQYG3mb/RBDu620PDIXl0abFAqievobMhbfvYW6GdeEoPEN8iXGYFBkxbfpJn8Y1y4f8
         F6SjQjXGRwZVR+lGXlZDhrUGxSdzCSH/YiD/bsD5q2GkFQLqoLWuw3S9nlwb/QcTf+/G
         D2dqk3uPHxSxGLiPz52WCid9DnN+TbYr8zJiLQQDEG4D0HgQVfXL2NqaKqq1E/1r4TBH
         gHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDdiyphkogtVcXTbSVRyR+FjzQZde+G185126UMJh7I=;
        b=FqK09UuKPbnkTp5cr/M59C3CS/0G1VUiWSKpPZGYGnFhf3cvESTvJIOKNT99K0JQWW
         94YQx6jf/wEOfPAMgLXKVYQ4jyexUafIizEho5o+60gtY676JXz054pQnCZlRGeE+ZbK
         iNQUDiyj4dVWkbfCGHEWY+A24Ust30dqn1whN6dMbg3amSu1pee1hVL6UVcFTLBwqAdP
         NFxbas1NF2GydgdwNnB+1UmIiR8ZLMcBrWSrp9/eDm1+NqGBwb+1TdDKAKoyaliNZOnd
         HAg862jPpdKwk8z83JCdl/e7QKcNiA5O+VbrwyYEeZ5VkNgcxfCezgKSYGtnq8A/vY2r
         rA/g==
X-Gm-Message-State: APjAAAWowood/MXr3+mWdzNZnyqDKy+H44xYOZkzeiuss/reIVjE46gE
        jMHLd+CdZ4lMl+j6lZ3XBDPIJII6PgPXJPuFEnCskA==
X-Google-Smtp-Source: APXvYqz43GD9Ydk/3iHIuvGx3dSX5DTZZLzaJSUOTfbGyq2mCG6ID5DjuBQ5u6fo5kf0q+kWNBtbkFi3ckrHB0dUqUs=
X-Received: by 2002:a9d:7f19:: with SMTP id j25mr3854222otq.25.1556829023216;
 Thu, 02 May 2019 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-8-brendanhiggins@google.com> <20190502105849.GB12416@kroah.com>
In-Reply-To: <20190502105849.GB12416@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 13:30:12 -0700
Message-ID: <CAFd5g44os8xEMMiROkmX_KM4-9yL=+y6kw4-JApxhdzJV5pwkg@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kunit: test: add initial tests
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 2, 2019 at 3:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 01, 2019 at 04:01:16PM -0700, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  kunit/Kconfig              | 12 ++++++
> >  kunit/Makefile             |  4 ++
> >  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
> >  kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
> >  4 files changed, 165 insertions(+)
> >  create mode 100644 kunit/example-test.c
> >  create mode 100644 kunit/string-stream-test.c
> >
> > diff --git a/kunit/Kconfig b/kunit/Kconfig
> > index 64480092b2c24..5cb500355c873 100644
> > --- a/kunit/Kconfig
> > +++ b/kunit/Kconfig
> > @@ -13,4 +13,16 @@ config KUNIT
> >         special hardware. For more information, please see
> >         Documentation/kunit/
> >
> > +config KUNIT_TEST
> > +     bool "KUnit test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables KUnit test to test KUnit.
> > +
> > +config KUNIT_EXAMPLE_TEST
> > +     bool "Example test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables example KUnit test to demo features of KUnit.
>
> Can't these tests be module?

At this time, no. KUnit doesn't support loading tests as kernel
modules; it is something we could add in in the future, but I would
rather not open that can of worms right now. There are some other
things I would like to do that would probably be easier to do before
adding support for tests as loadable modules.

>
> Or am I mis-reading the previous logic?
>
> Anyway, just a question, nothing objecting to this as-is for now.

Cool

Cheers!
