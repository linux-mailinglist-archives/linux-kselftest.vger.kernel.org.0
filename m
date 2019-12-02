Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22A10F1EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 22:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLBVKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 16:10:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42579 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBVKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 16:10:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so1123606ljo.9;
        Mon, 02 Dec 2019 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI0vrIcnx4OyiLwsy+iUg8MBW9que6as4Vgej46HfQE=;
        b=Pwu4o8nZY8nAcf27eWcYyvVgM7fHYu7v1RJJh+M6sl0RXXqubD4tPL0g2jEL8Zze8X
         rbryxAGu1R2fuQC4EgocyoSpuNQRCN4rI3XMOj4FBWpafOlbRjIZ9BG+VoKZOFgsZrbD
         L1dckW2Is1XYBluqMpZ3FPFJdCNHH0hy3QWAo1nlt4k6hPIQnfenYO6JbLA6IET7Yh3B
         doELxvTNHLAqLx+MiZVO8c8XTTRNaN106vAaI2iiISq84b83LMRhCCQougdGqsuuWPZD
         cT/eIkXw2e8MCHUSEJfQBLmzF29prSnvnQ3v2TqOM6ZGSJ/Qmf0z6GD9CEhsj3+NkyAQ
         bv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI0vrIcnx4OyiLwsy+iUg8MBW9que6as4Vgej46HfQE=;
        b=hGZ8SBZo8rgUXlkoGQVkqZQ4f2imuosAHiYcSymynrmsCDQzOalnMI2veZjDO2LpBC
         rA766St+8Mc7N0RUVoHr3snFj+SHsWnnrALuHro1Ucua989QFwa4M8LNDKPeP+K30WKF
         4rcPwyrU3KlD2B9bRSGwnYVeZt35Aa1s8YSBgRYBOVvl3QiglAu8Hu2yYRFpFsin0Ove
         /udzhsymBZ/7w2Th3xA9xGBzZz24dIjQEoTpFV8fRypf855VJFml8315pxaoFgb6qxvk
         Kzp+gqDThlk72bMjitoooo8QVi7rZKoEMQKZowCOMxSD2s0VllI4n3XujyznMKNgZFiK
         Q8zg==
X-Gm-Message-State: APjAAAUSy+7NuS8PaTBfebKlKStKKEfC8puuZoET438Jn9HAKZiBtFl9
        UHbssPSR3TP4XfvYFEZwUZYErOeZ/qJJoCBdNxI=
X-Google-Smtp-Source: APXvYqzuMeAo6CLh8G4KVix8Vb7c5xmu/o1UZpX1Y8VMOBlfI9bXc9O8atB+enauwtCcjG+rK+xRSNJPzPFP22O9nWw=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr468856ljc.161.1575321015559;
 Mon, 02 Dec 2019 13:10:15 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <1575242724-4937-3-git-send-email-sj38.park@gmail.com> <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
 <CABVgOS=xYiqVNND3JxgRLPv--0ZNC+h=FB0oZc2sKmVk4HJ95A@mail.gmail.com>
In-Reply-To: <CABVgOS=xYiqVNND3JxgRLPv--0ZNC+h=FB0oZc2sKmVk4HJ95A@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Mon, 2 Dec 2019 22:09:49 +0100
Message-ID: <CAEjAshqVQNwQo+yiAYhKXC0k=ZHx2MKZAB90hO2PLw9STMZ8=w@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 2, 2019 at 10:03 PM David Gow <davidgow@google.com> wrote:
>
> On Mon, Dec 2, 2019 at 9:25 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > +David Gow - David has lots of good opinions on our documentation.
> >
> > On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > The kunit 'Getting Started' document first shows the wrapper running
> > > command.  However, a new user who simply following the command might
> > > encounter a failure like below:
> > >
> > >     $ ./tools/testing/kunit/kunit.py run
> > >     Traceback (most recent call last):
> > >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> > >         main(sys.argv[1:])
> > >       File "./tools/testing/kunit/kunit.py", line 126, in main
> > >         linux = kunit_kernel.LinuxSourceTree()
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> > >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> > >         with open(path, 'r') as f:
> > >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> > >
> > > Though the reason of the failure ('kunitconfig') is explained in its
> > > next section, it would be better to reduce any failure that user might
> > > encounter.  This commit removes the example command for the reason.
> >
> > Seems reasonable.
> >
> I definitely agree that having a non-working command here is doing
> more harm than good. Whether we just get rid of it, or change it to
> use the --defconfig option is a matter of taste. (Personally, I think
> there's some value in having a one-line "run the tests" command at the
> top of the Getting Started page, but it definitely needs to be one
> that works.)
>
> So, overall, I think this is definitely an improvement, but that we do
> need to choose whether to take this approach (deleting this command)
> or the --defconfig approach as in:
> https://lore.kernel.org/linux-kselftest/20191119003120.154041-1-brendanhiggins@google.com/
>
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  Documentation/dev-tools/kunit/start.rst | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > > index 78a0aed..e25978d 100644
> > > --- a/Documentation/dev-tools/kunit/start.rst
> > > +++ b/Documentation/dev-tools/kunit/start.rst
> > > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> > >  easily use and read KUnit output. It handles building and running the kernel, as
> > >  well as formatting the output.
> > >
> > > -The wrapper can be run with:
> > > -
> > > -.. code-block:: bash
> > > -
> > > -   ./tools/testing/kunit/kunit.py run
> > > -
> > >  Creating a kunitconfig
> > >  ======================
> >
> > I think maybe we should demote this section so that this is a
> > subsection under KUnit Wrapper. Might also want to add a tie-in
> > explaining why we are talking about kunitconfig here? Right now this
> > kind of reads as a non sequitur.
> I generally think we want to keep the "Getting Started" guide focused
> on the goal (running/writing tests), rather than too much detail on
> the implementation (the wrapper itself).
> How about renaming what's currently the "KUnit Wrapper" section to
> "Running tests" or similar, and moving the kunitconfig part under
> that?
>
> The "Creating a kunitconfig" part could equally be "configuring which
> tests to run" or something, which may speak more to motivating
>
> As for some sort of tie-in, perhaps rewording the opening sentence to
> say "The easiest way to run tests is to use the kunit_tool script",
> and link to the page kunit_tool page in the patch below?
> >
> > Note: we have tried to address this potential issue for new users in
> > this patch under review:
> >
> > https://patchwork.kernel.org/patch/11252953/
> >
> > I don't feel strongly whether we do it your way or my way. What do
> > other people think?
>
> As above, my slight preference is for adding the --defconfig option
> over removing the section entirely.

Agree, I would also prefer to do explain about '--defconfig' option.

Thanks,
SeongJae Park

>
> > >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > > --
> > > 2.7.4
> > >
> On Mon, Dec 2, 2019 at 9:25 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > +David Gow - David has lots of good opinions on our documentation.
> >
> > On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > The kunit 'Getting Started' document first shows the wrapper running
> > > command.  However, a new user who simply following the command might
> > > encounter a failure like below:
> > >
> > >     $ ./tools/testing/kunit/kunit.py run
> > >     Traceback (most recent call last):
> > >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> > >         main(sys.argv[1:])
> > >       File "./tools/testing/kunit/kunit.py", line 126, in main
> > >         linux = kunit_kernel.LinuxSourceTree()
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> > >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> > >         with open(path, 'r') as f:
> > >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> > >
> > > Though the reason of the failure ('kunitconfig') is explained in its
> > > next section, it would be better to reduce any failure that user might
> > > encounter.  This commit removes the example command for the reason.
> >
> > Seems reasonable.
> >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  Documentation/dev-tools/kunit/start.rst | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > > index 78a0aed..e25978d 100644
> > > --- a/Documentation/dev-tools/kunit/start.rst
> > > +++ b/Documentation/dev-tools/kunit/start.rst
> > > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> > >  easily use and read KUnit output. It handles building and running the kernel, as
> > >  well as formatting the output.
> > >
> > > -The wrapper can be run with:
> > > -
> > > -.. code-block:: bash
> > > -
> > > -   ./tools/testing/kunit/kunit.py run
> > > -
> > >  Creating a kunitconfig
> > >  ======================
> >
> > I think maybe we should demote this section so that this is a
> > subsection under KUnit Wrapper. Might also want to add a tie-in
> > explaining why we are talking about kunitconfig here? Right now this
> > kind of reads as a non sequitur.
> >
> > Note: we have tried to address this potential issue for new users in
> > this patch under review:
> >
> > https://patchwork.kernel.org/patch/11252953/
> >
> > I don't feel strongly whether we do it your way or my way. What do
> > other people think?
> >
> > >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > > --
> > > 2.7.4
> > >
