Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE0111BBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 23:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLCWgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 17:36:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37431 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfLCWgF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 17:36:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so2558868pfm.4
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 14:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r06+KrKZmbSJH6UUm02fNkOof8/gjixGbcfjblQ+qRs=;
        b=qmmaebzoB44V44DUoG8FAhCTP3bWZxhuWc/e85o0mdI6Hg+gGv8FZsbinUlNKbd+cB
         SML2TNJLyK+1Kz5vJTHNbPffrS+dZYi3mWcVJEvQXoePAoP/scqeV34UCbocwPR6YFB6
         R4C/xrXvcfFez3m0kS8tQZ97SM/tpq2yM16XDitDpBR9BwH4IuYvXRNj9zz8dtypvU4Z
         JgmqbL+mAilAq2eBnhxfjTy+simzyTz5k7LbYN9oWVWjzwPzTekeGkc9P3LScLtACFmK
         MBXNDmluF4EhFW2ZAuR87z06qoWJveYtsGKQsHRz45F5zAAjEwhvdPwulQQGoFKsAC21
         wGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r06+KrKZmbSJH6UUm02fNkOof8/gjixGbcfjblQ+qRs=;
        b=b0/0Q/VCA2dvnLMhn6iSqQeosYItcwJemjYZgiZkgbzaP/QOeB/7YzLSzNqnys4wuT
         AFdqRyttAzeh/4QXvYjTTR8shr4SQa7iXyfnEwV/zngE3XEqoB6puz2ktoyUlXSY9M9J
         jJedXFClwIelq0HZkH0dFPVvtuprDnXN1sDWspBQR+aoqYjEqjBiVaO1PDUO/ZLg+uRX
         aMvjngQZBwBM/ppaTs4uLxBgr3iuiR2ZIJmrPZhfzwk3Wkxa7RuV+hVDUY9Nxpk2xuuO
         VS8wg0NDrAVhlBAI9IniCnyyzlKHQP73PvzJaRFSEUdGEV/5FV3YDF2zZXABzJ0GB2oH
         fVbw==
X-Gm-Message-State: APjAAAV9WnCQZPg7TR//Bm57Lo8RuLCmty1vVpbQc+Sx0fNrrkxQPcNQ
        ejIPjqYkpqx6WbnwjT5qhM04hsW7e8tBoiyCsLVUIg==
X-Google-Smtp-Source: APXvYqxWObr1MDrGkYFSZAzjU0wyoXqLlbyFY+LBrt8mBQKO1DqOKm01gXn/4tlInbMN4BHmYN9VZEP1u5qBzoGNkK8=
X-Received: by 2002:a63:480f:: with SMTP id v15mr7802935pga.201.1575412564268;
 Tue, 03 Dec 2019 14:36:04 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <20191203070025.GA4206@google.com> <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
 <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com>
 <CAFd5g46qPPsKJFqs07Eiea0Nim=YDWbOUndJu=JbW--VcTb-ww@mail.gmail.com> <CAEjAshpTAj_aYBUG1PWoyPajT69hWptXOZKwydg6duTNV5=aLQ@mail.gmail.com>
In-Reply-To: <CAEjAshpTAj_aYBUG1PWoyPajT69hWptXOZKwydg6duTNV5=aLQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:35:53 -0800
Message-ID: <CAFd5g46VZ10FeKJspSQXWc+zHervGQk5brOxei+S53OO5kYfTQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 10:11 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Tue, Dec 3, 2019 at 6:45 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 12:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > You're right, the error was due to the assumption of the existence of the
> > > build_dir.  The "kunit: Create default config in '--build_dir'" patch made the
> > > bug.  I fixed it in the second version patchset[1].
> > >
> > > [1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/
> >
> > After trying your new patches, I am still getting the
> > "FileNotFoundError" when the given build_dir has not been created.
>
> Sorry, apparently my mistake...  Sent v3 fixing it:
> https://lore.kernel.org/linux-kselftest/1575396508-21480-1-git-send-email-sj38.park@gmail.com/T/#t

Awesome, looks like that works now!

Thanks for taking care of this!

> Thanks,
> SeongJae Park
>
>
> >
> > > Thanks,
> > > SeongJae Park
> > >
> > > On Tue, Dec 3, 2019 at 8:10 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > >
> > > > > > This patchset contains trivial fixes for the kunit documentations and the
> > > > > > wrapper python scripts.
> > > > > >
> > > > > > SeongJae Park (6):
> > > > > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > > > > >   docs/kunit/start: Skip wrapper run command
> > > > > >   kunit: Remove duplicated defconfig creation
> > > > > >   kunit: Create default config in 'build_dir'
> > > > > >   kunit: Place 'test.log' under the 'build_dir'
> > > > > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > > > > >
> > > > > >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> > > > > >  tools/testing/kunit/kunit.py            | 10 ++++++----
> > > > > >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> > > > > >  3 files changed, 14 insertions(+), 21 deletions(-)
> > > > >
> > > > > I applied your patchset to torvalds/master, ran the command:
> > > > >
> > > > > tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
> > > > >
> > > > > and got the error:
> > > > >
> > > > > Traceback (most recent call last):
> > > > >   File "tools/testing/kunit/kunit.py", line 140, in <module>
> > > > >     main(sys.argv[1:])
> > > > >   File "tools/testing/kunit/kunit.py", line 123, in main
> > > > >     create_default_kunitconfig()
> > > > >   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
> > > > >     kunit_kernel.KUNITCONFIG_PATH)
> > > > >   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
> > > > >     with open(dst, 'wb') as fdst:
> > > > > FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
> > > > >
> > > > > It seems that it expects the build_dir to already exist; however, I
> > > > > don't think this is clear from the error message. Would you mind
> > > > > addressing that here?
> > > >
> > > > Thank you for sharing this.  I will take a look!
> > > >
> > > >
> > > > Thanks,
> > > > SeongJae Park
> > > > >
> > > > > Cheers!
