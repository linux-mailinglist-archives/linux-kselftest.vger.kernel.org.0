Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6064D89
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2019 22:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfGJU1z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jul 2019 16:27:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40513 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfGJU1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jul 2019 16:27:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so1614335pfp.7
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2019 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
        b=DXE2TyoaAsiT9dgVdMLJlwnFOJG+VPwltPNRpKt3x1FLvKASU/iQDS/su9pWcI6ZPd
         MXkkWpKWuusX2P8emSJdJDlt30oE5SxYRezHyYxpjjVp3ZbcLi8A3iWXovzH83yYRc8k
         fjxQns6K5/tsiMazqiGGWLPX8o1RPbeCk84rZYGhBrbKZfsdxcSVvoPDO0y7puTr2iGH
         fQNI4xvqDUtOGBpEZRrc5xNRkpC2AFKD+tShr+e3Bwk8ghWvxHexXjknk4e4/Fuddr4K
         h5eIBtrjZWB7rbYTWe1Z8/fz44NvT2DlWtjdcUYum8NYmtJkqcBIajW2gxCHzFBMqhlz
         2q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
        b=CKQObK/UTlJTG9nC9cJfRlRXCwm9HT/10jxO01XVAfPxEOV8jELD7uAIugVognM5Xk
         WJSqfWpADpZpIILK0H/YwjCd3QWVCZsMRjpJ4H18Y3rph/DFQydRsmkeH/Mq1/gPnGY2
         bulEWmRbt0EgULiTijZJoxgbtDLXeHuRF2niEi835graz+qWcQ4wkPGbwwNbnBAqCprG
         MFNUTA4THwANQ+W1HdeADzG/QrYjxSQN+B1od9KFBSb6dOkRb7jv4i+9E9X3WFkzYip+
         IDhBtgDEo1jr3Ib9kNilJ+M2W7RoN1I9TZ1t1N8lb8otMMFZ/fIYgUcEt0yG/7Mq6iun
         L7aw==
X-Gm-Message-State: APjAAAXaaSX3xovY1J3Qs9KHcThRqdwYbTXzob/wtuU/6RjZcP2oiu6u
        5ZfIs9KJdMtdN/H64HaFy9ZFyBG1/SaHJ4IdAXMNWQ==
X-Google-Smtp-Source: APXvYqzZdlWhCkBvFW8XUuT2KDhsG6TgutjUsDP74lsWb4XjESrHCjQll9Q/yu+3XrTs4ARL+yM6pPyLsGbtB4DuWT0=
X-Received: by 2002:a63:205f:: with SMTP id r31mr109331pgm.159.1562790473396;
 Wed, 10 Jul 2019 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com> <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
 <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
In-Reply-To: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 10 Jul 2019 13:27:42 -0700
Message-ID: <CAFd5g45zFhBN-yrJbRt6KnFkYKxVqjs9qeQULCSD6z89vvG-Tg@mail.gmail.com>
Subject: Re: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
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

On Tue, Jul 9, 2019 at 11:01 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
> >
> > On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > > framework.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > ---
> > >   MAINTAINERS | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 677ef41cb012c..48d04d180a988 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8599,6 +8599,17 @@ S:     Maintained
> > >   F:  tools/testing/selftests/
> > >   F:  Documentation/dev-tools/kselftest*
> > >
> > > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > > +M:   Brendan Higgins <brendanhiggins@google.com>
> > > +L:   linux-kselftest@vger.kernel.org
> > > +L:   kunit-dev@googlegroups.com
> > > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > > +S:   Maintained
> > > +F:   Documentation/dev-tools/kunit/
> > > +F:   include/kunit/
> > > +F:   kunit/
> > > +F:   tools/testing/kunit/
> > > +
> > >   KERNEL USERMODE HELPER
> > >   M:  Luis Chamberlain <mcgrof@kernel.org>
> > >   L:  linux-kernel@vger.kernel.org
> > >
> >
> > Thanks Brendan.
> >
> > I am good with this. I can take KUnit patches through kselftest
> > with your Ack.
>
> My acknowledgement? Sure! I thought we already agreed to that.
>
> Also, do we need an ack from Masahiro or Michal for the Kbuild patch
> [PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
> [PATCH v7 08/18]?

By the way, I am guessing you have already seen it, but I uploaded a
new version to incorporate a suggestion made by Masahiro on patch
06/18. In addition, I have gotten acks on the two patches mentioned
above. So I think we are good to go.

Thanks!
