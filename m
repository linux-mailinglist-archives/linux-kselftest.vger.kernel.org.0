Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD8110415
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLCSLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:11:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43366 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCSLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:11:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so2295499lfq.10;
        Tue, 03 Dec 2019 10:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9g/Y/Bt40KbJDiW5JOJCnl3btsiJd4zL6Ayui/PxS9w=;
        b=UfhJWpRkr9o6OerC+nd7VlQE/uyYA7iUskCVoHhYzPbBGCZZs8/RkUA0Yy2g5vZIoR
         DZN4Ppim07wll+Egp+aWPIrF4DW101YwHwpGcPVbFSViq9ufGMdxiBpVqRmXHQqAJ/g2
         0Wk775mVV48A4vG9NpcXMhzXwYO3bqAuDKXqVbzrlX1JEH9Xwk4Udz3Pm+h6hOHGgfs4
         fBPPlA13r7G0vT4HJsuHK6Uahamvj4cdvEI7/8q7UAPfvVtEqgZSwkhNwlZpLbcCsM6k
         /0c77BOovYKJlyst/tbOLxj3lJinwGtftpAzueP1Rgu7YunQ7em3LdosAuRFm8NAE+tm
         EIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9g/Y/Bt40KbJDiW5JOJCnl3btsiJd4zL6Ayui/PxS9w=;
        b=FP4EbhRWPztiedp0DIxeVPqoLHylXDoGW5iUorAbWiZw8JuFZKlLIOMxrpiCgc+g4Z
         1qWS+A+oF7o7ZsZWZV385d6mb9dbYBY6+r7WjzQiBSuFJNh6YJt0iah2UxszdgkVX65S
         QSMlmhJ9KfgdkO31At54xAa+Ihk0q+WDFSBNyfl3Q2ipuMAI9znQkVOMM1PdJqf0vQ/I
         P1CnVW+VOGH4h9MSHZ+P1Ucy9gUR7VKM7VfXDb4ArIfZrv4//H1jppdG78iQv3WlFjUI
         vKZt2xXvwJnDFgxzcZoI2k5q5HXIvn93MYq/lavfjO1D+WZfO9kLWPath9UMdVAskOpj
         /Ocg==
X-Gm-Message-State: APjAAAUmUssZLx+UfwdNIdUtzw3lTymwE9+RMEnml4VCejKSg4yVHU13
        a6/kqRP36Gehpn6hkzlJLMQJhItSN3XQX1AdfV4=
X-Google-Smtp-Source: APXvYqx6dExbD8o0Glt5fztVJXYXC5iw9XbfbbKHxoGp7nWMkkWalgNU1aj+WSVgO/kDeG0wDxjJkLsn4DIspy4to90=
X-Received: by 2002:ac2:531b:: with SMTP id c27mr3421907lfh.91.1575396665854;
 Tue, 03 Dec 2019 10:11:05 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <20191203070025.GA4206@google.com> <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
 <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com> <CAFd5g46qPPsKJFqs07Eiea0Nim=YDWbOUndJu=JbW--VcTb-ww@mail.gmail.com>
In-Reply-To: <CAFd5g46qPPsKJFqs07Eiea0Nim=YDWbOUndJu=JbW--VcTb-ww@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 3 Dec 2019 19:10:39 +0100
Message-ID: <CAEjAshpTAj_aYBUG1PWoyPajT69hWptXOZKwydg6duTNV5=aLQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix nits in the kunit
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Tue, Dec 3, 2019 at 6:45 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 12:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > You're right, the error was due to the assumption of the existence of the
> > build_dir.  The "kunit: Create default config in '--build_dir'" patch made the
> > bug.  I fixed it in the second version patchset[1].
> >
> > [1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/
>
> After trying your new patches, I am still getting the
> "FileNotFoundError" when the given build_dir has not been created.

Sorry, apparently my mistake...  Sent v3 fixing it:
https://lore.kernel.org/linux-kselftest/1575396508-21480-1-git-send-email-sj38.park@gmail.com/T/#t


Thanks,
SeongJae Park


>
> > Thanks,
> > SeongJae Park
> >
> > On Tue, Dec 3, 2019 at 8:10 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > >
> > > > > This patchset contains trivial fixes for the kunit documentations and the
> > > > > wrapper python scripts.
> > > > >
> > > > > SeongJae Park (6):
> > > > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > > > >   docs/kunit/start: Skip wrapper run command
> > > > >   kunit: Remove duplicated defconfig creation
> > > > >   kunit: Create default config in 'build_dir'
> > > > >   kunit: Place 'test.log' under the 'build_dir'
> > > > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > > > >
> > > > >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> > > > >  tools/testing/kunit/kunit.py            | 10 ++++++----
> > > > >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> > > > >  3 files changed, 14 insertions(+), 21 deletions(-)
> > > >
> > > > I applied your patchset to torvalds/master, ran the command:
> > > >
> > > > tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
> > > >
> > > > and got the error:
> > > >
> > > > Traceback (most recent call last):
> > > >   File "tools/testing/kunit/kunit.py", line 140, in <module>
> > > >     main(sys.argv[1:])
> > > >   File "tools/testing/kunit/kunit.py", line 123, in main
> > > >     create_default_kunitconfig()
> > > >   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
> > > >     kunit_kernel.KUNITCONFIG_PATH)
> > > >   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
> > > >     with open(dst, 'wb') as fdst:
> > > > FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
> > > >
> > > > It seems that it expects the build_dir to already exist; however, I
> > > > don't think this is clear from the error message. Would you mind
> > > > addressing that here?
> > >
> > > Thank you for sharing this.  I will take a look!
> > >
> > >
> > > Thanks,
> > > SeongJae Park
> > > >
> > > > Cheers!
