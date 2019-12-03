Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF51103CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLCRpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 12:45:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45063 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCRpo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 12:45:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so1962822plz.12
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7N6iQZ6w+KnK1x580YAK+IgWlbj+L7z26/RNYAhP3E=;
        b=QpxjuqLNn8DPHEmW8Mne7bHFbkHFrWcadhd3+9wt8gWJJIslzBTmim1TD5pOW0dvaA
         bC76EQ7govwprkNb75aGyD6KHY8ymXR5N5w6Caa7L8wSLQ8o6YSIh5c8qGyJKwLNR5rV
         6tCVzWrx/V9AD8Wf/hpe4/4M2sZYDEa5fP87n24haNU0l1cBwtmastId7QhfBbfz8tpB
         nWWGDUBjCE44/t64p3fJ3FPUQNbKUKjxqw+zdrcFFOL8bd+Lh7WxRAF0+EazzRUNLgF8
         4eSmnS+upC3AWrGrfZYAOw40jtAJYKZ0evSwDw4C01BQqyVmi2IWQBkkHsc/FPsTTzL+
         PB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7N6iQZ6w+KnK1x580YAK+IgWlbj+L7z26/RNYAhP3E=;
        b=WoRn9nzkpVFDvQNyaegN82GkCoIf3tWspGMz6ZMN3JGc4YL0l7NItV8UxuC5X2bRXt
         Z+xb3Sqz0dbW/9VcNLFAkcCGXw28gzsxcXTXTEHk9LrooVcOdJMam2knt5tHLGSFWjYI
         jvF1OY4o9YcCuN40xJLXu888s+mdfwbANlv+8rHcTJXYrd5+4iJSWi/wdjumJK2wYRd9
         otesxmMLLSHNxF8HLhoxjjxID1r4cVi2W236HQ0bans721HXemX7cGfOsIXg2OrlgN5/
         QpoiU5OBQYPckSA6KiF2wE/CDniiI/KeytXHZzDNmVTmRtDbzBjiFwBeEIqtjqc0CfGa
         WHrA==
X-Gm-Message-State: APjAAAVHmdlHH2b9VX7Ru5/QhVsMMe9YynxPNT/12UycQNmX2ODFOvtf
        yHws/lDRLZbdJZ7fwC0XD4nSt2UU1uQOYPy2KykXwg==
X-Google-Smtp-Source: APXvYqykkKXbum3SSjV3LDPg92I2gZuwgqFvaKWHVvCaYAZ8GyCh+gaXA/1WQQhyvLYBi43QZL+p4VYGPLTqotMNZac=
X-Received: by 2002:a17:90a:ff12:: with SMTP id ce18mr4019224pjb.117.1575395143149;
 Tue, 03 Dec 2019 09:45:43 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <20191203070025.GA4206@google.com> <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
 <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com>
In-Reply-To: <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 09:45:31 -0800
Message-ID: <CAFd5g46qPPsKJFqs07Eiea0Nim=YDWbOUndJu=JbW--VcTb-ww@mail.gmail.com>
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

On Tue, Dec 3, 2019 at 12:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> You're right, the error was due to the assumption of the existence of the
> build_dir.  The "kunit: Create default config in '--build_dir'" patch made the
> bug.  I fixed it in the second version patchset[1].
>
> [1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/

After trying your new patches, I am still getting the
"FileNotFoundError" when the given build_dir has not been created.

> Thanks,
> SeongJae Park
>
> On Tue, Dec 3, 2019 at 8:10 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > This patchset contains trivial fixes for the kunit documentations and the
> > > > wrapper python scripts.
> > > >
> > > > SeongJae Park (6):
> > > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > > >   docs/kunit/start: Skip wrapper run command
> > > >   kunit: Remove duplicated defconfig creation
> > > >   kunit: Create default config in 'build_dir'
> > > >   kunit: Place 'test.log' under the 'build_dir'
> > > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > > >
> > > >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> > > >  tools/testing/kunit/kunit.py            | 10 ++++++----
> > > >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> > > >  3 files changed, 14 insertions(+), 21 deletions(-)
> > >
> > > I applied your patchset to torvalds/master, ran the command:
> > >
> > > tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
> > >
> > > and got the error:
> > >
> > > Traceback (most recent call last):
> > >   File "tools/testing/kunit/kunit.py", line 140, in <module>
> > >     main(sys.argv[1:])
> > >   File "tools/testing/kunit/kunit.py", line 123, in main
> > >     create_default_kunitconfig()
> > >   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
> > >     kunit_kernel.KUNITCONFIG_PATH)
> > >   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
> > >     with open(dst, 'wb') as fdst:
> > > FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
> > >
> > > It seems that it expects the build_dir to already exist; however, I
> > > don't think this is clear from the error message. Would you mind
> > > addressing that here?
> >
> > Thank you for sharing this.  I will take a look!
> >
> >
> > Thanks,
> > SeongJae Park
> > >
> > > Cheers!
