Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BBFD0AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 23:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNWFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 17:05:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34928 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKNWFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 17:05:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id q22so4669139pgk.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2019 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUB/MflXzCJMG7Y2M0r0tuE4n+oLMmgrXK9Lt9807D8=;
        b=LvqeDdWj4/BvmlCJtUczgpCAZ/S1nczS+iFKbFLDS1G4JiiacIQh5AF3nVq1WdR/mk
         QJK1r46xfNrokg5Pl3xNjKO+c8ITdvqKffKTEWkP4qYSo/lN6vdwR2fpu769g4FtUHEP
         DIdSm+3HHQbqeXN5QAAA+5+W46uYGsSH1+Y7nj9MDkPomeX8CXKdjL5EKcqUHA+0UnVZ
         JQd5IAP5Yf3yNnQmIcFycHbmE8BddReimJfqlttqMaLk3t2Y3K6nN7TllXlCGRvJFUGv
         8+zg2TpENXotCecZPZsTMu5+MKOU9MUazHSC1VIIl3HV01YOrJlPH3DOXwk/8q8iBBMy
         R6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUB/MflXzCJMG7Y2M0r0tuE4n+oLMmgrXK9Lt9807D8=;
        b=pptcyZYqtzolv0t//MqLDSCrWUYe0/BmPDS/BOuhRkvGJzxLfOCDfU8cfKuGJ/ZE7I
         gSDPDg+Jyn2LAs50irPWQ12ShByrUHCXzLfmJcGzXRFQEs8WRLqbitTBtoXsJD6uXEXh
         vSE3rJR1Ly+d4hQhZUenalfr+bnw/iuf6ZQqc0jp/xqFTi1hSCVuk4PyEPrr9KYtV8St
         vAmBeQyiWWDGIaO7rqOtumtf7rOaLAx71Q4sM5nZqds6GuwZ/cmh0ncS7WlUHRYF4JU4
         N9G+9dmoiHinWuJSc93vvAIzfIIxmtFbiSVPkBQ/qg3QXeaCiT9/pfSL2DhVQSL1QJUD
         aUSg==
X-Gm-Message-State: APjAAAXtLuuvQPJNq56QIqWjpDujq9qwIstU00R27Bk1QUJqk4czqtoN
        PAR149a63jtwCY04JcHMjc/3uZw2PPn0ipCg6qUekg==
X-Google-Smtp-Source: APXvYqxeHKt2jaGM/C2bqfmau+yuCpw0lKb5aGNis1EqWTGVYXbjSOtTjbZIlvJaYLskYN1vYrwdSdEo/swVvRGXK3Y=
X-Received: by 2002:a63:4721:: with SMTP id u33mr4321514pga.159.1573769147313;
 Thu, 14 Nov 2019 14:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20191113012746.52804-1-brendanhiggins@google.com> <CABVgOS=3AXS1=rpGyNiNYu8hU+t=gQG9JongHXir=76ENnrnnA@mail.gmail.com>
In-Reply-To: <CABVgOS=3AXS1=rpGyNiNYu8hU+t=gQG9JongHXir=76ENnrnnA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Nov 2019 14:05:36 -0800
Message-ID: <CAFd5g45jxFgxPSaamT3EQB5W_HMbM5-FPyRppqTb-HFTn+oGow@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] Documentation: kunit: add
 documentation for kunit_tool
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 13, 2019 at 10:12 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, Nov 12, 2019 at 5:28 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Add documentation for the Python script used to build, run, and collect
> > results from the kernel known as kunit_tool. kunit_tool
> > (tools/testing/kunit/kunit.py) was already added in previous commits.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst      |  1 +
> >  Documentation/dev-tools/kunit/kunit-tool.rst | 57 ++++++++++++++++++++
> >  Documentation/dev-tools/kunit/start.rst      |  3 ++
> >  3 files changed, 61 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index 26ffb46bdf99d..c60d760a0eed1 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
> >
> >         start
> >         usage
> > +       kunit-tool
> >         api/index
> >         faq
> >
> > diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> > new file mode 100644
> > index 0000000000000..aa1a93649a45a
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> > @@ -0,0 +1,57 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=================
> > +kunit_tool How-To
> > +=================
> > +
> > +What is kunit_tool?
> > +===================
> > +
> > +kunit_tool is a set of scripts that aid in building the Linux kernel as UML
> > +(`User Mode Linux <http://user-mode-linux.sourceforge.net/old/>`_), running
> > +KUnit tests, parsing the test results and displaying them in a user friendly
> > +manner.
>
> Calling this a "set of scripts" is a bit confusing, as the only script
> described is tools/testing/kunit/kunit.py, which isn't mentioned in
> this section.

Fair enough. Sorry, I think of it as a set of scripts since there is
more than one file, but I guess that probably doesn't make too much
sense to anyone else.

> Also, it may be worth linking to the new version of the UML website
> (even if the old one has more content).

No complaints here. I just linked to what I thought is more helpful.
It isn't immediately obvious to click on the old site (however, you
probably want to since it has way more useful content), but the old
site *is* discoverable from the new site, and the inverse is not true.

> > +
> > +What is a kunitconfig?
> > +======================
> > +
> > +It's just a defconfig that kunit_tool looks for in the base directory.
> > +kunit_tool uses it to generate a .config as you might expect. In addition, it
> > +verifies that the generated .config contains the CONFIG options in the
> > +kunitconfig; the reason it does this is so that it is easy to be sure that a
> > +CONFIG that enables a test actually ends up in the .config.
> > +
> > +How do I use kunit_tool?
> > +=================================
> > +
> > +If a kunitconfig is present at the root directory, all you have to do is:
> > +
> > +.. code-block:: bash
> > +
> > +       ./tools/testing/kunit/kunit.py run
> > +
> > +However, you most likely want to use it with the following options:
> > +
> > +.. code-block:: bash
> > +
> > +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8
> > +
> > +- ``--timeout`` sets a maximum amount of time to allow tests to run.
> > +- ``--jobs`` sets the number of threads to use to build the kernel.
> > +
>
> Not directly an issue with the documentation, but this does raise the
> question of why we don't have better defaults. Alternatively, maybe

Better defaults, yes-ish: I think Ted's suggestion that we should make
it possible to run KUnit tests from make[1] is correct, and if I
remember correctly, make *does* have a way to set reasonable
system-wide defaults for this (I just don't think anybody takes
advantage of it), so in that case, we should just respect whatever
make wants to do. Consequently, I think the logic in the script should
probably be pretty dumb.

> this doc could suggest --jobs=`nproc` or similar?

Good suggestion, although I would do --jobs=`nproc --all `.

> > +If you just want to use the defconfig that ships with the kernel, you can
> > +append the ``--defconfig`` flag as well:
> > +
> > +.. code-block:: bash
> > +
> > +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8 --defconfig
> > +
> > +.. note::
> > +       This command is particularly helpful for getting started because it
> > +       just works. No kunitconfig needs to be present.
> > +
>
> Should we use this in the getting started section below, then?
> Particularly since we're already going over kunitconfigs there
> separately.

I think that makes sense.

> > +For a list of all the flags supported by kunit_tool, you can run:
> > +
> > +.. code-block:: bash
> > +
>
> Do you think it's worth documenting the remaining two (--build_dir and
> --raw_output) here too?

No. I don't know that I want to set the precedent to document all
flags here. We already document the flags in the code and I don't want
the two to get out of sync. However, it might be feasible to have the
documentation automagically execute the --help command every time it
is built keeping it in sync. I am not sure how much value that would
provide.

> > +       ./tools/testing/kunit/kunit.py run --help
[...]

Cheers!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205535
