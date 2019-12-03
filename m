Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13910F9CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCI00 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:26:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:26:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so2156979lfl.9;
        Tue, 03 Dec 2019 00:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8kDvKKiOlbnRIjKL76dToNxNX272P7IDgc+CwJbZiM=;
        b=tU5W4ZkW1HPq3oAToFaAdfTwx4AFmZYjVT5SREKvqCsjKlcqQL+U6JFDkuze3xwVrt
         vLdKwAOYs8mevxiQEkCiKqOTI2agUCPu32sAsS0FUuVxGcv4OW8Y85yN59R1ai7wr55M
         Rhwh0yBPS5Msf70yWjhqHSxo0DbSEs4oZGrKlvJxN69i7LFCeEUWJi6GM2DkgkV0PawI
         Fu0wPi4rNg81sW/Xso9NQ7wVm59m+ktMyGf9UScdaFVjuz6THlx1aS0wcD0/c/1AXuLH
         wVFIxx4B5WWMRYQYZZQfJgszzZZmIGF2PEKg72rywRJB34N/3Lwr+RDzYZujwXpnK0+/
         +dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8kDvKKiOlbnRIjKL76dToNxNX272P7IDgc+CwJbZiM=;
        b=lNKQQIFOW+ArVOXc1kq0Bglp+EqYuJlFpMFtlr8uTVl0eyXzPLld+d32IYuaQdDpiS
         L/fwiJ/kCM6FAv0N9IMEoET+BZuKbuHvDQd4lCOqyteU2+x/kDPcj6BYy5McFEDKp+SZ
         A3CEbpdCtr5KZXFk8pFIykBEKqYiTOWViqiRwqywlGqvV8MwIelCXRFfh9nuDfU6kiky
         /FyGZklV1XAr5IxGqUkfClYRmgLpOG/q4PIUReKdf9XVw37xYU7iu28GSlXmFhbVZK0x
         9B/lnVYz73k692jy4rhAuDWq4KWqBOheGdqoFw0otgI/DnwMG2zReweauxI6IGa4WqpB
         KK2A==
X-Gm-Message-State: APjAAAVvLVo+ZW9rNifTC/8VGjUFn2P+tYdNE/81GF9AxfnpyRtsHnz1
        Knff4+0INaxPA5OfFF8XBiJeSPM4/amyi6sobYS8IZun
X-Google-Smtp-Source: APXvYqzBwvQuWWWBTq/Ef5fBREDgL/6W7GiJJ/wtmT5q3dw/ZUF+4Q1GFjE51MwrFxSai1M/UBc5ZpQb96W6usSJ7Ag=
X-Received: by 2002:ac2:4436:: with SMTP id w22mr1884577lfl.185.1575361584349;
 Tue, 03 Dec 2019 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <20191203070025.GA4206@google.com> <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
In-Reply-To: <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 3 Dec 2019 09:25:57 +0100
Message-ID: <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com>
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

You're right, the error was due to the assumption of the existence of the
build_dir.  The "kunit: Create default config in '--build_dir'" patch made the
bug.  I fixed it in the second version patchset[1].

[1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/


Thanks,
SeongJae Park

On Tue, Dec 3, 2019 at 8:10 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > This patchset contains trivial fixes for the kunit documentations and the
> > > wrapper python scripts.
> > >
> > > SeongJae Park (6):
> > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > >   docs/kunit/start: Skip wrapper run command
> > >   kunit: Remove duplicated defconfig creation
> > >   kunit: Create default config in 'build_dir'
> > >   kunit: Place 'test.log' under the 'build_dir'
> > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > >
> > >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> > >  tools/testing/kunit/kunit.py            | 10 ++++++----
> > >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> > >  3 files changed, 14 insertions(+), 21 deletions(-)
> >
> > I applied your patchset to torvalds/master, ran the command:
> >
> > tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
> >
> > and got the error:
> >
> > Traceback (most recent call last):
> >   File "tools/testing/kunit/kunit.py", line 140, in <module>
> >     main(sys.argv[1:])
> >   File "tools/testing/kunit/kunit.py", line 123, in main
> >     create_default_kunitconfig()
> >   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
> >     kunit_kernel.KUNITCONFIG_PATH)
> >   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
> >     with open(dst, 'wb') as fdst:
> > FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
> >
> > It seems that it expects the build_dir to already exist; however, I
> > don't think this is clear from the error message. Would you mind
> > addressing that here?
>
> Thank you for sharing this.  I will take a look!
>
>
> Thanks,
> SeongJae Park
> >
> > Cheers!
